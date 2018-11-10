from flask_wtf import FlaskForm
from flask_wtf.file import FileField, FileAllowed
from flask_login import current_user
from wtforms import StringField, PasswordField, SubmitField, BooleanField, TextAreaField, SelectField, RadioField
from wtforms.validators import DataRequired, Length, Email, EqualTo, ValidationError
from corkboardPro.models import user


class RegistrationForm(FlaskForm):
    username = StringField('Username',
                           validators=[DataRequired(), Length(min=2, max=20)])
    email = StringField('Email',
                        validators=[DataRequired(), Email()])
    password = PasswordField('Password', validators=[DataRequired()])
    confirm_password = PasswordField('Confirm Password',
                                     validators=[DataRequired(), EqualTo('password')])
    submit = SubmitField('Sign Up')

    def validate_username(self, username):
        user1 = user.query.filter_by(name=username.data).first()
        if user1:
            raise ValidationError('That username is taken. Please choose a different one.')

    def validate_email(self, email):
        user2 = user.query.filter_by(email=email.data).first()
        if user2:
            raise ValidationError('That email is taken. Please choose a different one.')


class LoginForm(FlaskForm):
    email = StringField('Email',
                        validators=[DataRequired(), Email()])
    password = PasswordField('Password', validators=[DataRequired()])
    remember = BooleanField('Remember Me')
    submit = SubmitField('Login')

class PrivateLoginForm(FlaskForm):
    password = PasswordField('Password', validators=[DataRequired()])
    submit = SubmitField('Login')


class UpdateAccountForm(FlaskForm):
    username = StringField('Username',
                           validators=[DataRequired(), Length(min=2, max=20)])
    email = StringField('Email',
                        validators=[DataRequired(), Email()])
    picture = FileField('Update Profile Picture', validators=[FileAllowed(['jpg', 'png'])])
    submit = SubmitField('Update')

    def validate_username(self, username):
        if username.data != current_user.username:
            user = User.query.filter_by(username=username.data).first()
            if user:
                raise ValidationError('That username is taken. Please choose a different one.')

    def validate_email(self, email):
        if email.data != current_user.email:
            user = User.query.filter_by(email=email.data).first()
            if user:
                raise ValidationError('That email is taken. Please choose a different one.')


class PostForm(FlaskForm):
    title = StringField('Title', validators=[DataRequired()])
    content = TextAreaField('Content', validators=[DataRequired()])
    submit = SubmitField('Post')

class CorkBoardForm(FlaskForm):
    title = StringField('Title', validators=[DataRequired()])
    # category = SelectField('Category', choices=['Education','People','Pets','Sprots','Food& Drink'])
    category = TextAreaField('Category', validators=[DataRequired()])
    # isPublic= BooleanField('Public')
    # isPrivate= BooleanField('Private')
    visibility = RadioField('visibility', choices = [('Public','Public'),('Private','Private')])
    password = TextAreaField('password')
    submit = SubmitField('Add')

    # def validate_password(self, password):

    #     pa= password.data
    #     if  visibility.data =='Private' and pa=='':
    #         raise ValidationError('Please enter password')

class PushPinForm(FlaskForm):
    image_URL = StringField('image_URL', validators=[DataRequired()])
    description = TextAreaField('descritption', validators=[DataRequired()])
    tags = StringField('tags', validators=[DataRequired()])
    submit = SubmitField('Add')

class CommentForm(FlaskForm):
    content = StringField('Content', validators=[DataRequired()])
    submit = SubmitField('Post Comment')

