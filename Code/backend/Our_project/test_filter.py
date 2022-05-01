import spacy

# load the deep learning dataset
nlp = spacy.load('en_core_web_sm')


blog_id = 8
blog_tilte = "How 1233 to built a kernel in my Virtual builds building build? machine Machines"
blog_content = "I am trying to build a kernel in my virtual machine, I use Mac, my virtual machine is Linux"

def filter_word(blog_list):
  blog_id = blog_list[0]
  blog_title = blog_list[1]
  blog_content = blog_list[2]

  # load the deep learning dataset
  nlp = spacy.load('en_core_web_sm')

  doc_title = nlp(blog_tilte)
  doc_content = nlp(blog_content)

  #创建字典 {token名字：出现的次数}
  token_dict = {}

  for token in doc_title:
    if not (token.is_punct or token.is_stop): # if not a punctuation or a stop word
      lemma_token = token.lemma_ # transform it to normal form (lemma)
      if lemma_token in token_dict:
        token_dict[lemma_token][0] += 1
      else:
        token_dict[lemma_token] = [1,0]
  
  # print(token_dict)
  
  #遍历内容所有数据
  for token in doc_content:
    if not (token.is_punct or token.is_stop): # if not a punctuation or a stop word
      lemma_token = token.lemma_ # transform it to normal form (lemma)
      if lemma_token in token_dict:
        token_dict[lemma_token][1] += 1
      else:
        token_dict[lemma_token] = [0,1]

  result_list = []

  for (key,value) in token_dict.items():
    mylist = []
    mylist.append(key)
    mylist.append(blog_id)
    mylist.append(value[0])
    mylist.append(value[1])
    result_list.append(mylist)



  print(result_list)
  return result_list


filter_word([12,blog_tilte,blog_content])