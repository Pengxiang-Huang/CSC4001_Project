import spacy

# load the deep learning dataset
nlp = spacy.load('en_core_web_sm')

blog_tilte = "How 1233 to built a kernel in my Virtual builds building build? machine Machines"

dim = 6
num_blog = 4
target_vec = [1, 3, 1, 1, 1, 2]
blog_vec_list = [[12,1,1,1,1,1,1], [13,1,2,3,4,5,6], [14,1,0,0,0,0,0],[15,6,5,4,3,2,1]]



def search_spilt(title):
  nlp = spacy.load('en_core_web_sm')
  
  doc_title = nlp(title)

  token_dict = {}

  for token in doc_title:
    if not (token.is_punct or token.is_stop):
      lemma_token = token.lemma_
      if lemma_token in token_dict:
        token_dict[lemma_token] += 1
      else:
        token_dict[lemma_token] = 1
  
  word_list = []
  count_list = []
  dim = 0
  for (key,value) in token_dict.items():
    dim += 1
    word_list.append(key)
    count_list.append(value)
  
  result = [dim, word_list,count_list]

  return result




# quick sort
def quicksort_blog(dim, target_vec, blog_vec_list, l, r):
    if(l < r):
        pivot = partition(dim, target_vec, blog_vec_list, l, r)
        quicksort_blog(dim, target_vec, blog_vec_list, l, pivot - 1)
        quicksort_blog(dim, target_vec, blog_vec_list, pivot + 1, r)
    return blog_vec_list

def partition(dim, target_vec, blog_vec_list, l, r):
    pivot = r
    i = l
    for j in range(l,r):
        if innerProduct(dim, blog_vec_list[j], target_vec) > innerProduct(dim, blog_vec_list[pivot], target_vec):
            blog_vec_list[j], blog_vec_list[i] = blog_vec_list[i], blog_vec_list[j]
            i += 1

    blog_vec_list[i], blog_vec_list[pivot] = blog_vec_list[pivot], blog_vec_list[i]

    return i


def innerProduct(dim, blog_vec, target_vec):
  result = 0
  for i in range(1, dim+1):
    result += target_vec[i-1] * blog_vec[i]

  return result 

print(search_spilt(blog_tilte))
print(quicksort_blog(dim, target_vec, blog_vec_list, 0, num_blog - 1))