# Load all the required libraries
library(pdftools)
library(tm)
library(tidytext)
library(dplyr)
library(wordcloud)
library(RColorBrewer)

# set working directory to the location of the PDF files
setwd("/Users/admin/Desktop/projects/r-starter/MDS503P2")

## Create a Data Corpus from PDF files

#Read all pdf file
pdf_file<- list.files(pattern = "*.pdf")
text_data<- lapply(pdf_file,pdf_text)

#combine text from all pdfs into one
full_text<- unlist(text_data)
data_corpus <- Corpus(VectorSource(full_text))

data_corpus <-tm_map(data_corpus,content_transformer(tolower))
data_corpus<-tm_map(data_corpus,removePunctuation)
data_corpus<-tm_map(data_corpus,removeNumbers)
data_corpus<-tm_map(data_corpus, stripWhitespace)
data_corpus<- tm_map(data_corpus, removeWords, stopwords("en"))  #remove stopwords like "the", "and", "is", "in", "of" etc


## Tokenization and word frequency
df<- data.frame(text = sapply(data_corpus, as.character),stringsAsFactors = F)

token_word<- df %>% unnest_tokens(word,text) %>% count(word, sort = T)

library(ggplot2)
token_word %>% 
  filter(n > 10)%>% 
  ggplot(aes(x = reorder(word,n), y = n)) + 
  geom_bar(stat= "identity",fill = "blue") +
  coord_flip() + 
  theme_minimal() +
  labs(title = "Most Common Words in PDF Corpus", x = "words", y = "Count")


# Form a Word Cloud
set.seed(1234)

wordcloud(
  words = token_word$word,
  freq = token_word$n,
  min.freq = 2,
  max.words = 100,
  colors = brewer.pal(5,"Dark2"),
  random.order = F
)