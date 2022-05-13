### 1. Introduction

#### 1.1 Project Overview

Our project, CUHKSZ-Stack-Overflow, mainly aims to provide a Q&A platform for CUHKSZ programmers who have technical questions about their Computer Science courses' projects or assignments in CUHK(SZ). It also offers a social channel where some of students, especially senior students, could share their programming and working experience, provide the guidance in CS learning, and give the specific suggestions to the other younger students who may encounter the same problem or situation. Since many students may be afraid of seeking assistance from the professor and the teaching assistants through WeChat, email or office hour, we hope to create an environment where students could bravely post their programming problems while other students or teachers would willingly to see and reply those questions. Hopefully this kind of communication will help students fully understand their homework, improve their programming skills and enable them to accumulate programming experience. Eventually, those communication and connection could save much time for students learning CS and also reduce the teaching load for TA at the same time, which definitely will enhance both learning and teaching qualities in Computer Science courses.

#### 1.2 Objective

Our thoughts of the system design come from a famous Q&A application Stack Overflow, which is a public platform building the definitive collection of coding Q&A for professional and enthusiast programmers. In detail, our system is divided into the frontend part and the backend part. In the frontend, users can perform many operations, including registering and logging in their accounts, posting and replying the questions, following questions or partitions, giving a like to questions or answers and setting filters and searching questions. In the backend, developers and servers deal with the data transfer and management, including performing transactions in the database, executing corresponding functions according to the  invokes from frontend and setting the relevant URL for the connection between frontend and backend. Moreover, an administrator account is designed for the management of the whole application. In short, our goal is to provide a satisfied and perfect CUHKSZ-Stack-Overflow Q&A system particularly for programmers in CUHKSZ.

#### 1.3 Highlights

##### 1.3.1 cloud deployment and website access by domain name

Distinguish from running the code in the local terminal and access the website by localhost, our project is deployed on the cloud server, so our project can be accessed directly by typing the URL http://175.178.34.84 without compiling and running the code in the terminal, thus leading to a more efficient way. Furthermore, a specific domain name is applied to make our project become more conspicuous, characteristic and elegant. In this case, our website can be accessed by typing the URL http://www.cuhksz-stackoverflow.cn. In short, we design and implement a website with an attractive domain name being easy to remember and a remote access from other devices.

##### 1.3.2 Search engine implementation - NLP and inverted index design in database

Initially, we use string match method which aims to divide the whole sentences into several words and find blogs whose title contains those words. It has some limitations. At first, the method cannot detect the words with tense inconsistency. For example, the word "make" in the search contents cannot find blogs whose title contains the word "made". Additionally, those words which do not have semantic meaning will also be considered in string match, thus causing a imperfect search results to some degree. For example, the search contents "how to learn programming" may find blogs whose title contains the word "to". Therefore, we improve our search engine algorithm and adopt the natural language processing algorithm. 

Apart from using NLP in the process of search content, we also use inverted index in our database. Since the workload of forward index is huge, which is caused by traversing all the records in a table to determine whether each record contains the related words, for example, if the user take "kernel" as inputs, record 1, record 2 and record 3 will be retrieved and then record 1 is found to meet the requirements (Table 1.3.2.1), we consider to build a table with inverted index (Table 1.3.2.2). With the application of inverted index, if the user take "kernel" as inputs, record 2 is found to meet the requirements and the blog id 1 is obtained to directly retrieve the corresponding blog, which improves the efficiency in getting data from the database. 

| blog_id | content                 |
| ------- | ----------------------- |
| 1       | How to build kernel     |
| 2       | How to learn C++        |
| 3       | How about my code below |

<center>Table 1.3.2.1 - Forward Index</center>

| id   | words  | blog_id |
| ---- | :----- | ------- |
| 1    | build  | {1}     |
| 2    | kernel | {1}     |
| 3    | learn  | {2}     |
| 4    | code   | {3}     |
| ..   | ..     | ..      |

<center>Table 1.3.2.2 - Inverted Index</center>

To sum up, the search content will first be split into words and then the words frequency is calculated to make up a vector (target_vec). For example, the user take "I want to learn build kernel" as inputs, the target_vec should be [1, 1, 1] where the first 1 means the word "learn" appears once in the content, the second 1 means the word "build" appears once in the content and the third 1 means the word "kernel" appears once in the content. Second, the inverted index table will be retrieved to get the list of words frequency according to the blogs. For example, the inverted index table is retrieved according to the words in the search content and the blog_vec can be obtained in the form of [[1, 0, 1, 1], [2, 1, 0, 0]] where the first value in each list represents the blog id and the rest three values in each list represents the frequency of the words in the blog content. Finally, the similarity is calculated by inner product and then list all the blogs in the descending order of the similarity. For example, [0, 1, 1] inner product with [1, 1, 1] is 2 and [1, 0, 0] inner product with [1, 1, 1] is 1. Therefore, the results contain blog 1 and blog 2, and the blog 1 is listed in the former of blog 2. 

#### 1.4 Project Statistics