from flask_wtf import FlaskForm
from flask_wtf.file import FileField, FileAllowed
from flask_login import current_user
from wtforms import StringField, PasswordField, SubmitField, BooleanField, TextAreaField, SelectField, RadioField
from wtforms.validators import DataRequired, Length, Email, EqualTo, ValidationError
from corkboardPro.models import user, category


class RegistrationForm(FlaskForm):
    username = StringField('Username',
                           validators=[DataRequired(), Length(min=2, max=20)])
    email = StringField('Email',
                        validators=[DataRequired(), Email()])
    password = PasswordField('Password', validators=[DataRequired(), Length(min=4, max=4)])
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

class CorkBoardForm(FlaskForm):
    title = StringField('Title', validators=[DataRequired()])
    myChoices = category.query.with_entities(category.cat_name, category.cat_name).all()
    category = SelectField('Category', choices = myChoices, validators=[DataRequired()])
    visibility = RadioField('visibility', choices = [('Public','Public'),('Private','Private')])
    password = PasswordField('password')
    submit = SubmitField('Add')

class PushPinForm(FlaskForm):
    image_URL = StringField('URL', validators=[DataRequired()])
    description = TextAreaField('Descritption', validators=[DataRequired(), Length(min=1, max=200)])
    # tags = StringField('Tags', validators=[DataRequired()])
    tags = StringField('Tags')
    submit = SubmitField('Add')

    def validate_tags(self, tags):
        tags_list = tags.data.strip(" ").split(',')
        for tag in tags_list:
            if len(tag) >= 20:
                raise ValidationError('Each tag length should limit 20 characters.')

class CommentForm(FlaskForm):
    content = StringField('Content', validators=[DataRequired()])
    submit = SubmitField('Post Comment')

