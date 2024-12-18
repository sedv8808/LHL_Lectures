import pandas as pd
from transformers import pipeline
from typing import List, Tuple


def create_pipe() -> pipeline:
    pipe = pipeline(
        task='sentiment-analysis',
        model='distilbert-base-uncased-finetuned-sst-2-english',
    )

    return pipe

def get_preds(
        pipeline_object,
        review: str | List[str] | pd.Series
    ) -> Tuple[str, float]:
    '''Predict the sentiment and confidence of the review'''
    
    if isinstance(review, pd.Series):
        review = review.tolist()
    
    prediction = pipeline_object(review)
    sentiment = prediction[0]['label']
    confidence = prediction[0]['score']

    return sentiment, confidence
