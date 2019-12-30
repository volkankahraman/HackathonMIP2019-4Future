from flask import Flask,render_template,url_for,request
from flask_bootstrap import Bootstrap
import pandas as pd 
import numpy as np 
from sklearn.externals import joblib
from flask import jsonify
import json
import model_egitim as m


app = Flask(__name__)
Bootstrap(app)

@app.route('/')
def index():
	return render_template('index.html')



@app.route('/sonuc')
def sonuc():
	return render_template('result.html')


@app.route('/giris')
def giris():
	return render_template('login.html')

@app.route('/predict',methods=['POST']) 
def predict():
	LR = joblib.load('models/LogistigRegressionModel2.pkl')
	columns_model = joblib.load('models/model_columns.pkl')
	
	if request.method == 'POST':
		yorum = request.form['yorum']
		sonuc = m.analiz(yorum)
		if sonuc == True:
			return jsonify(prediction = 'Olumlu')
		else :
			return jsonify(prediction = 'Olumsuz')


if __name__ == '__main__':
	app.run(debug=True)
