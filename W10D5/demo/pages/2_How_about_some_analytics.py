import pandas as pd
import plotly.express as px
import streamlit as st

from typing import Tuple
from utils import create_pipe, get_preds


st.title('Food Truck Review Wars :hotdog: :pizza: :taco:')

st.markdown("""
Three food trucks are competing for the title of **"BEST FOOD TRUCK IN TOWN"**.  
The winner will be determined by customer feedback.  

Here are the contenders:
- Frankly Fantastic: :hotdog:
- Pizza Palooza: :pizza:
- Tasty Tacolicious: :taco:
            
They each received 10 reviews from customers and we want to quickly get the sentiment of each of the reviews.
"""
)


@st.cache_data
def load_data(filepath, delimiter='\t') -> pd.DataFrame:
    df = pd.read_csv(filepath, delimiter=delimiter)
    return df


@st.cache_data
def add_preds(df: pd.DataFrame, review_column: str='review') -> pd.DataFrame:
    pipe = create_pipe()
    
    sentiment_list = []

    for review in df[review_column]:
        sentiment, _ = get_preds(pipeline_object=pipe, review=review)
        sentiment = sentiment.title()
        sentiment_list.append(sentiment)

    df['sentiment'] = sentiment_list

    return df


def gouped_bar(df: pd.DataFrame) -> None:
    fig = px.histogram(
        df,
        x='food_truck',
        y='sentiment',
        histfunc='count',
        color='sentiment', 
        barmode='group',
        title='Reviews by food truck and sentiment',
        labels={'food_truck': 'Food Truck', 'sentiment': 'Sentiment'},
        category_orders={'sentiment': ['Positive', 'Negative']},
        color_discrete_map={'Positive': '#33A352', 'Negative': '#cc0202'},
    )

    fig.update_layout(yaxis_title='Number of Reviews')
    fig.update_yaxes(range=[0, 10])

    return fig


def winner(df: pd.DataFrame) -> Tuple[str, int]:
    positive_reviews = df[df['sentiment'] == 'Positive']
    positive_counts = positive_reviews['food_truck'].value_counts()
    most_positive_truck = positive_counts.idxmax()
    count_positive_sentiment = positive_counts.max()

    return most_positive_truck, count_positive_sentiment


df = load_data('demo/food_truck_reviews.tsv')
df_with_preds = add_preds(df)
fig = gouped_bar(df_with_preds)
most_positive_truck, count_positive_sentiment = winner(df_with_preds)
best_truck = (
    df_with_preds[df_with_preds['food_truck'] == most_positive_truck]
    .loc[:, ['review', 'sentiment']]
)


st.write(fig)
st.write('And the winner is...')
st.header(f':trophy: {most_positive_truck.upper()}')
st.write(f'{count_positive_sentiment}/10 positive reviews')

st.markdown("### Let's see what their customers had to say about them")

st.data_editor(
    best_truck,
    column_config={
        'review': st.column_config.TextColumn(
            label='Review',
            help='Customer review :memo:'
        ),
        'sentiment': st.column_config.TextColumn(
            label='Sentiment',
            help='Predicted sentiment :crystal_ball:',
        )
    },
    hide_index=True
)
