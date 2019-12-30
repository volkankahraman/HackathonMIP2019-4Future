import pandas as pd
import numpy as np
from sklearn.utils import shuffle
from sklearn.externals import joblib

import json
with open('data/json.json') as f:
  data = json.load(f)

data = pd.DataFrame(data)

df_olumlu = data[data.sentiment =='positive']
df_olumsuz = data[data.sentiment =='negative']
df = pd.concat([df_olumlu, df_olumsuz], ignore_index = True)
df = shuffle(df)


from sklearn.model_selection import train_test_split

X_train, X_test, y_train, y_test = train_test_split(df['comment'], df['sentiment'], random_state = 0,test_size =0.1)


from sklearn.feature_extraction.text import CountVectorizer
max_features = 1000

vect = CountVectorizer(max_features= max_features,encoding ='utf8').fit(X_train)


feature_list = vect.get_feature_names()

from sklearn.externals import joblib
joblib.dump(feature_list,'models/feature_list.pkl')

X_train_vectorized = vect.transform(X_train) 

from sklearn.linear_model import LogisticRegression
model = LogisticRegression()
model.fit(X_train_vectorized, y_train)


joblib.dump(model, 'models/LogistigRegressionModel2.pkl')
print("LogisticRegression dumped!")


model_columns = list(df.columns)
joblib.dump(model_columns, 'models/model_columns.pkl')
print("Models columns dumped!")

def analiz(yorum):
	prediction = model.predict(vect.transform([yorum]))
	if(prediction == 'negative'):
		return  False
	else:
		return  True

b = analiz("iyi")



