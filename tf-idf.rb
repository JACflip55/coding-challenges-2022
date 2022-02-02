# def say_hello
#   puts 'Hello, World'
# end

# 5.times { say_hello }


# 
# Your previous Python 3 content is preserved below:
# 
# """
# Problem: compute TF-IDF for a set of documents
# 
# TF-IDF = TF * IDF
# 
# Term Frequency (TF)
# The number of times a word appears in a document divided by total number of words in the given document
# <1
# 
# Inverse Document Frequency (IDF)
# The log10 of ( the number of documents divided by the number of documents that contain the word w).
# >1,
# 
# TF-IDF
# these numbers are random
#             the man children ... on
# document_A 0.1 0.8 0
# document_B .24
# """

document_A = 'the man went out for a walk the'  
document_B = 'the children sat around the fire'
document_C = 'the woman ran around the park'
document_D = 'the person ran through fire on a walk'


class MyDocument

  def initialize(name, document)
    @name = name
    @document = document
  end
  
  attr_reader :name

  def word_counts

    word_counts = Hash.new(0)

    words = @document.split

    words.each do |w|

      word_counts[w] += 1

    end

    word_counts

  end


  def total_words
  
    @document.split.size
  end
  
  def term_frequency(term)
    
    word_counts[term].to_f/total_words
  end
  
end

class MyCorpus
  
  def initialize(documents)
    
    @documents = documents
  end
  
  def size
    
    @documents.size
  end
  
  def contains_w(w)
    
    @documents.select{ |d| d.word_counts[w] > 0 }
  end
  
  def inverse_document_frequency(w)
        
    
    Math.log10(size.to_f/contains_w(w).size)
  end
  
  def tf_idf(doc, w)
    
    tf = doc.term_frequency(w)
    idf = inverse_document_frequency(w)
    
    return tf*idf
    
  end
  
  def document_summary doc
    
    summary = {}
    
    unique_words = doc.word_counts.keys
    
    unique_words.each do |w|
      
      summary[w] = tf_idf(doc, w)
    end
    
    summary
    
  end
  
  def summaries
  
    summary = {}
    
    @documents.each do |doc|
      
      summary[doc.name] = document_summary(doc)
    end
    
    summary
    
  end
  
end

docA = MyDocument.new 'A', 'the man went out for a walk the'  
docB = MyDocument.new 'B', 'the children sat around the fire'
docC = MyDocument.new 'C', 'the woman ran around the park'
docD = MyDocument.new 'D', 'the person ran through fire on a walk'
docE = MyDocument.new 'E', 'the man and woman person ran through fire on a walk in the park with their dog however the children did not and were not in the fire'
docF = MyDocument.new 'F', 'did the boss fire the man like a boss'





corpus = MyCorpus.new [docA, docB, docC, docD, docE, docF]

# puts docA.total_words
# puts docA.term_frequency('the')

#puts corpus.contains_w "man"

pp corpus.summaries


#puts corpus.tf_idf(docA, 'man')

#document => word =>
