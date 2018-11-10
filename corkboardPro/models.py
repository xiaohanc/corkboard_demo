from datetime import datetime
from corkboardPro import db, login_manager
from flask_login import UserMixin


@login_manager.user_loader
def load_user(user_id):
    return user.query.get(int(user_id))


# class User(db.Model, UserMixin):
#     id = db.Column(db.Integer, primary_key=True)
#     username = db.Column(db.String(20), unique=True, nullable=False)
#     email = db.Column(db.String(120), unique=True, nullable=False)
#     image_file = db.Column(db.String(20), nullable=False, default='default.jpg')
#     password = db.Column(db.String(60), nullable=False)
#     posts = db.relationship('Post', backref='author', lazy=True)
#
#     def __repr__(self):
#         return f"User('{self.username}', '{self.email}', '{self.image_file}')"


class user(db.Model,UserMixin):
    def get_id(self):
        return (self.userID)

    userID = db.Column(db.Integer, primary_key=True)
    email = db.Column(db.String(250), unique=True, nullable=False)
    pin = db.Column(db.String(60), nullable=False)
    name = db.Column(db.String(100), nullable=False)

    def __repr__(self):
        return f"User('{self.name}', '{self.email}')"


class Post(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), nullable=False)
    date_posted = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    content = db.Column(db.Text, nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)

    def __repr__(self):
        return f"Post('{self.title}', '{self.date_posted}')"


class category(db.Model):
    categoryID= db.Column(db.Integer, primary_key=True)
    cat_name= db.Column(db.String(250) ,unique=True, nullable=False)

class corkboard(db.Model):
    corkBoardID= db.Column(db.Integer, primary_key=True)
    email = db.Column(db.String(250), db.ForeignKey('user.email') , nullable=False)
    cat_name= db.Column(db.String(250) , db.ForeignKey('category.cat_name') , nullable=False)
    title = db.Column(db.String(250),nullable=False)
    last_update= db.Column(db.DateTime, nullable=True)

class privatecorkboard(db.Model):
    corkBoardID= db.Column(db.Integer, db.ForeignKey('corkboard.corkBoardID'), primary_key=True)
    password = db.Column(db.String(250), nullable=False)
    last_update= db.Column(db.DateTime, nullable=True)

class publiccorkboard(db.Model):
    corkBoardID= db.Column(db.Integer, db.ForeignKey('corkboard.corkBoardID'), primary_key=True)
    last_update= db.Column(db.DateTime, nullable=True)


# class CorkBoard(db.Model):
#     corkBoardID= db.Column(db.Integer, primary_key=True)
#     email = db.Column(db.String(250), db.ForeignKey('user.email') , nullable=False)
#     cat_name= db.Column(db.String(250), db.ForeignKey('category.cat_name') , nullable=False)
#     title = db.Column(db.String(250),nullable=False)
#     last_update= db.Column(db.DateTime, nullable=True)



class pushpin(db.Model):
    pushPinID = db.Column(db.Integer, primary_key=True)
    corkBoardID=  db.Column(db.Integer, db.ForeignKey('corkboard.corkBoardID'), nullable=False )
    image_URL= db.Column(db.String(250), nullable=False)
    description = db.Column(db.String(250), nullable=False)
    pinned_time = db.Column(db.DateTime, nullable=True)

class tag(db.Model):
    tagID = db.Column(db.Integer, primary_key=True)
    pushPinID=  db.Column(db.Integer, db.ForeignKey('pushpin.pushPinID'), nullable=False)
    tag = db.Column(db.String(250), nullable=False)

class follow(db.Model):
    followID = db.Column(db.Integer, primary_key=True)
    email=  db.Column(db.String(250), nullable=False)
    owner_email = db.Column(db.String(250), nullable=False)
