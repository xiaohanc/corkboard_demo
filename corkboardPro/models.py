from datetime import datetime
from corkboardPro import db, login_manager
from flask_login import UserMixin

@login_manager.user_loader
def load_user(user_id):
    return user.query.get(int(user_id))

class user(db.Model,UserMixin):
    def get_id(self):
        return (self.userID)

    userID = db.Column(db.Integer, primary_key=True)
    email = db.Column(db.String(250), unique=True, nullable=False)
    pin = db.Column(db.String(60), nullable=False)
    name = db.Column(db.String(100), nullable=False)

    def __repr__(self):
        return f"User('{self.name}', '{self.email}')"

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

class watch(db.Model):
    WatchID = db.Column(db.Integer, primary_key=True)
    email=  db.Column(db.String(250), nullable=False)
    corkBoardID= db.Column(db.Integer, db.ForeignKey('corkboard.corkBoardID'), nullable=False)


class likes(db.Model):
    LikesID = db.Column(db.Integer, primary_key=True)
    email=  db.Column(db.String(250), db.ForeignKey('user.email'), nullable=False)
    pushPinID= db.Column(db.Integer, db.ForeignKey('pushpin.pushPinID'), nullable=False)


class comment(db.Model):
    commentID = db.Column(db.Integer, primary_key=True)
    email=  db.Column(db.String(250), db.ForeignKey('user.email'), nullable=False)
    content= db.Column(db.String(250), nullable=True)
    pushPinID= db.Column(db.Integer, db.ForeignKey('pushpin.pushPinID'), nullable=False)
    added_time = db.Column(db.DateTime, nullable=True)
