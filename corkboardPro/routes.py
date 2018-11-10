import os
import pdb
import secrets
from PIL import Image
from flask import render_template, url_for, flash, redirect, request, abort, session
from corkboardPro import app, db, bcrypt
from corkboardPro.forms import RegistrationForm, LoginForm, UpdateAccountForm, PostForm, CorkBoardForm, PushPinForm
from corkboardPro.models import user, Post, corkboard, privatecorkboard, publiccorkboard, pushpin,tag
from flask_login import login_user, current_user, logout_user, login_required
from sqlalchemy import text
from datetime import datetime

@app.route("/home")
def home():
    page = request.args.get('page', 1, type=int)
    posts = Post.query.order_by(Post.date_posted.desc()).paginate(page=page, per_page=5)
    return render_template('home.html', posts=posts)

@app.route("/")
@app.route("/home_screen")
def home_screen():
    if not current_user.is_authenticated:
        return redirect(url_for('login'))
    show_recent = """
    (SELECT CorkBoard.corkBoardID, CorkBoard.email, CorkBoard.cat_name, CorkBoard.title, CorkBoard.last_update, PrivateCorkboard.password, User.name
    FROM Follow, CorkBoard, PrivateCorkboard, User
    WHERE Follow.email= '""" + current_user.email + """' AND Follow.owner_email=CorkBoard.email and PrivateCorkboard.corkBoardID=Corkboard.corkBoardID and User.email= Follow.owner_email
    ORDER BY CorkBoard.last_update DESC LIMIT 4)
    UNION
    (SELECT CorkBoard.corkBoardID, CorkBoard.email, CorkBoard.cat_name, CorkBoard.title, CorkBoard.last_update, NULL as password, User.name
    FROM Follow, CorkBoard, PublicCorkboard, User
    WHERE Follow.email= '""" + current_user.email + """' AND Follow.owner_email=CorkBoard.email and PublicCorkboard.corkBoardID=Corkboard.corkBoardID and User.email= Follow.owner_email
    ORDER BY CorkBoard.last_update DESC LIMIT 4)
    UNION
    (SELECT CorkBoard.corkBoardID,corkBoard.email, CorkBoard.cat_name, CorkBoard.title, CorkBoard.last_update, NULL as password, User.name
    FROM Watch, corkBoard, User
    WHERE Watch.email='""" + current_user.email + """' and Watch.corkBoardID = corkBoard.corkBoardID and User.email= corkBoard.email
    ORDER BY CorkBoard.last_update DESC LIMIT 4);
    """
    # sql = text(show_recent.replace("\n", ""))
    sql1 = text(show_recent)
    result1 = db.engine.execute(sql1)
    recent_info = []
    for row in result1:
        recent_info.append(row)

    show_my_info = """
    (SELECT CorkBoard.corkBoardID, CorkBoard.title, COUNT(PushPin.pushPinID), NULL as password
    FROM PublicCorkBoard, corkBoard, PushPin
    WHERE CorkBoard.email = '""" + current_user.email + """'  and corkBoard.corkBoardID = PublicCorkBoard.corkBoardID and pushPin.corkBoardID=corkBoard.corkBoardID
    GROUP By pushPin.corkBoardID
    ORDER BY corkBoard.title LIMIT 3)
    UNION
    (SELECT CorkBoard.corkBoardID,CorkBoard.title, COUNT(PushPin.pushPinID), PrivateCorkboard.password
    FROM PrivateCorkBoard, corkBoard, PushPin
    WHERE CorkBoard.email = '""" + current_user.email + """' and corkBoard.corkBoardID = PrivateCorkBoard.corkBoardID and pushPin.corkBoardID=corkBoard.corkBoardID
    GROUP By pushPin.corkBoardID
    ORDER BY corkBoard.title LIMIT 3);
    """
    sql2 = text(show_my_info)
    result2 = db.engine.execute(sql2)
    my_info = []
    for row in result2:
        my_info.append(row)

    return render_template('home_screen.html', current_user=current_user, recent_info=recent_info, my_info=my_info)

@app.route("/about")
def about():
    return render_template('about.html', title='About')


@app.route("/register", methods=['GET', 'POST'])
def register():
    if current_user.is_authenticated:
        return redirect(url_for('home_screen'))
    form = RegistrationForm()
    if form.validate_on_submit():
        hashed_password = bcrypt.generate_password_hash(form.password.data).decode('utf-8')
        user1 = user(name=form.username.data, email=form.email.data, pin=hashed_password)
        db.session.add(user1)
        db.session.commit()
        flash('Your account has been created! You are now able to log in', 'success')
        return redirect(url_for('login'))
    return render_template('register.html', title='Register', form=form)


@app.route("/login", methods=['GET', 'POST'])
def login():
    if current_user.is_authenticated:
        return redirect(url_for('home_screen'))
    form = LoginForm()
    if form.validate_on_submit():
        user1 = user.query.filter_by(email=form.email.data).first()
        if user1 and bcrypt.check_password_hash(user1.pin, form.password.data):
            login_user(user1, remember=form.remember.data)
            next_page = request.args.get('next')
            return redirect(next_page) if next_page else redirect(url_for('home_screen'))
        else:
            flash('Login Unsuccessful. Please check email and password', 'danger')
    return render_template('login.html', title='Login', form=form)


@app.route("/logout")
def logout():
    logout_user()
    return redirect(url_for('home_screen'))


def save_picture(form_picture):
    random_hex = secrets.token_hex(8)
    _, f_ext = os.path.splitext(form_picture.filename)
    picture_fn = random_hex + f_ext
    picture_path = os.path.join(app.root_path, 'static/profile_pics', picture_fn)

    output_size = (125, 125)
    i = Image.open(form_picture)
    i.thumbnail(output_size)
    i.save(picture_path)

    return picture_fn


@app.route("/account", methods=['GET', 'POST'])
@login_required
def account():
    form = UpdateAccountForm()
    if form.validate_on_submit():
        if form.picture.data:
            picture_file = save_picture(form.picture.data)
            current_user.image_file = picture_file
        current_user.username = form.username.data
        current_user.email = form.email.data
        db.session.commit()
        flash('Your account has been updated!', 'success')
        return redirect(url_for('account'))
    elif request.method == 'GET':
        form.username.data = current_user.name
        form.email.data = current_user.email
    image_file = url_for('static', filename='profile_pics/default.jpg')
    return render_template('account.html', title='Account',
                           image_file=image_file, form=form)


@app.route("/post/new", methods=['GET', 'POST'])
@login_required
def new_post():
    form = PostForm()
    if form.validate_on_submit():
        post = Post(title=form.title.data, content=form.content.data, author=current_user)
        db.session.add(post)
        db.session.commit()
        flash('Your post has been created!', 'success')
        return redirect(url_for('home'))
    return render_template('create_post.html', title='New Post',
                           form=form, legend='New Post')


@app.route("/post/<int:post_id>")
def post(post_id):
    post = Post.query.get_or_404(post_id)
    return render_template('post.html', title=post.title, post=post)


@app.route("/post/<int:post_id>/update", methods=['GET', 'POST'])
@login_required
def update_post(post_id):
    post = Post.query.get_or_404(post_id)
    if post.author != current_user:
        abort(403)
    form = PostForm()
    if form.validate_on_submit():
        post.title = form.title.data
        post.content = form.content.data
        db.session.commit()
        flash('Your post has been updated!', 'success')
        return redirect(url_for('post', post_id=post.id))
    elif request.method == 'GET':
        form.title.data = post.title
        form.content.data = post.content
    return render_template('create_post.html', title='Update Post',
                           form=form, legend='Update Post')


@app.route("/post/<int:post_id>/delete", methods=['POST'])
@login_required
def delete_post(post_id):
    post = Post.query.get_or_404(post_id)
    if post.author != current_user:
        abort(403)
    db.session.delete(post)
    db.session.commit()
    flash('Your post has been deleted!', 'success')
    return redirect(url_for('home'))


@app.route("/user/<string:username>")
def user_posts(username):
    page = request.args.get('page', 1, type=int)
    user = User.query.filter_by(username=username).first_or_404()
    posts = Post.query.filter_by(author=user)\
        .order_by(Post.date_posted.desc())\
        .paginate(page=page, per_page=5)
    return render_template('user_posts.html', posts=posts, user=user)


@app.route("/populartags", methods=['GET', 'POST'])
@login_required
def popular_tags():
    return render_template('popular_tags.html')


@app.route("/search?q=<string:search_item>")
@login_required
def search_result(search_item):
    search_query = """
    SELECT pushPin.pushPinID, pushPin.Description, pushPin.Image_URL, corkBoard.Title, User.name 
    FROM PushPin, CorkBoard, User 
    WHERE CorkBoard.cat_name LIKE '%$""" + search_item + """%' and PushPin.corkBoardID = CorkBoard.corkBoardID and CorkBoard.email = User.email
    Union 
    SELECT pushPin.pushPinID, PushPin.Description, PushPin.Image_URL, CorkBoard.Title, User.name 
    FROM PushPin, CorkBoard, User 
    WHERE PushPin.description LIKE '%$""" + search_item + """%' and PushPin.corkBoardID = CorkBoard.corkBoardID and CorkBoard.email = User.email
    Union
    SELECT pushPin.pushPinID, PushPin.Description, PushPin.Image_URL, CorkBoard.Title, User.name 
    FROM PushPin, CorkBoard, User 
    WHERE PushPin.description LIKE '%$""" + search_item + """%' and PushPin.corkBoardID = CorkBoard.corkBoardID and CorkBoard.email = User.email
    """
    sql1 = text(search_query)
    result1 = db.engine.execute(sql1)
    pushpins = []
    for row in result1:
        pushpins.append(row)
    return render_template('search_results.html', search_item= search_item, pushpins = pushpins)


@app.route("/corkboard/new", methods=['GET', 'POST'])
@login_required
def new_corkboard():
    form = CorkBoardForm()
    if form.validate_on_submit():
        corkBoard1 = corkboard(email= current_user.email ,title=form.title.data, cat_name='cat1', last_update= None )
        db.session.add(corkBoard1)
        db.session.commit()
        if form.visibility.data=='Private':
            pricorkBoard1= privatecorkboard(corkBoardID= corkBoard1.corkBoardID, password= form.password.data, last_update= None)
            db.session.add(pricorkBoard1)
            db.session.commit()
        else:
            pubcorkBoard1= publiccorkboard(corkBoardID= corkBoard1.corkBoardID, last_update= None)
            db.session.add(pubcorkBoard1)
            db.session.commit()

        flash('Your Corkboard has been created!', 'success')
        return redirect(url_for('home_screen'))
    return render_template('create_corkboard.html', title='New Corkboard',
                           form=form, legend='New CorkBoard')
    # form = PostForm()
    # if form.validate_on_submit():
    #     post = Post(title=form.title.data, content=form.content.data, author=current_user)
    #     db.session.add(post)
    #     db.session.commit()
    #     flash('Your post has been created!', 'success')
    #     return redirect(url_for('home'))
    # return render_template('create_post.html', title='New Post',
    #                        form=form, legend='New Post')


@app.route("/corkboard/<int:corkboard_id>")
@login_required
def corkboards(corkboard_id):
    corkboard1 = corkboard.query.get_or_404(corkboard_id)
    session['corkID']= corkboard_id
    pushpins= pushpin.query.filter(pushpin.corkBoardID==corkboard_id).all()
    # pdb.set_trace()

    return render_template('corkboard.html', title=corkboard1.title, corkboard= corkboard1, pushpins=pushpins)


@app.route("/pushpin/new", methods=['GET', 'POST'])
@login_required
def new_pushpin():
    form = PushPinForm()
    if form.validate_on_submit():
        corkboard_ID= session.get('corkID', None)
        pushpin1 = pushpin(corkBoardID= corkboard_ID, image_URL=form.image_URL.data, description=form.description.data, pinned_time= datetime.utcnow() )
        db.session.add(pushpin1)
        db.session.commit()
        tag1 = tag(pushPinID= pushpin1.pushPinID, tag= form.tags)
        db.session.add(pushpin1)
        db.session.commit()

        flash('Your PushPin has been created!', 'success')
        return redirect( url_for('corkboards', corkboard_id=corkboard_ID))
    return render_template('create_pushpin.html', title='New PushPin',
                           form=form, legend='New PushPin')


@app.route("/pushpin/<int:pushpin_id>")
@login_required
def pushpins(pushpin_id):
    pushpin1 = pushpin.query.get_or_404(pushpin_id)
    corkboard1 = corkboard.query.get_or_404(pushpin1.corkBoardID)
    # pdb.set_trace()

    return render_template('pushpin.html', title=corkboard1.title, corkboard= corkboard1, pushpin=pushpin1)
