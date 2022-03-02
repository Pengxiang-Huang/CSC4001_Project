# Project Design Document

[TOC]

## 1. Introduction

### 1.1 Project Overview

Our project, CUHKSZ-Stack-Overflow mainly aims to provide a Q&A platform for CUHKSZ programmers who have technical questions about their Computer Science courses' projects or assignments in CUHK(SZ). It aslo offers a social channel where some of students, especially senior students,  could share their programming and working experience, provide the guidance in CS learning, and give the specific suggestions to the other younger students who may encouter the same problem or situation.  We hope to create an environment where students could bravely post their programming problems while other students or teachers would willingly  to see and reply those questions. Hopefully this kind of communication will help students fully understand their homework,  also improve their programming skill and accumulate programming experience.  Those comunication and connection eventually could save much time for students learning CS also reduce the teaching load for TA at the same time, which definatle will enhance both learning and teaching quality in Computer Science courses. 



### 1.2 Objective

Our System design comes from a famous Q&A application StackOverflow. It is a public platform building the definitive collection of coding Q&A for professional and enthusiast programmers. The system is divided into two parts, the fronted part which users could search, post and reply the questions, and the backend part, where developers and servers deal with the data transfer and management. Our goal is to provide a satisfied and perfect CUHKSZ-Stack-Overflow Q&A systetm particularly for programmers in CUHKSZ. 



### 1.3 Expected Customers and Market

The target users of our system are programmers (all students take Computer Science course in our school, TAs, professors ) of CUHKSZ. Every one who has an email account  for registration would be welcomed to join the system as customers. Users could create their account password in system when they first sign up the website. They will create their nickname and other background information like the age, intersted research carrer, CS courses already taken, etc. They also need to sign up a contract to make sure they have the obligations to maintain Community harmony.



### 1.4 System Features

Our system is mainly composed of 6 parts, including registration and login, Searching relavent questions, Posting new questions, Answering and replying problems, Displying the highlight and hot questions or topic,  ranking the excellent answers.  Users could upload their questions online and also have the access to invite the people to answer their questions. They also could browse those hot questions that remain answered to see if they could help or join in the disscussion. Moreover, the searching function is also valid for users. They are allowed to search the questions by themselves with various filter type that could narrow down their searching range.  More details of these features will be included in later sections. 



## 2. Background

Our group observe that many student-programmers from CUHKSZ may encounter many familiar programming questions in their project or assignment. Their solutions mainly include: searching online, emailing TAs or professors, uploading questions in WeChat group, or assigning an office hour.  Searching online sometimes may not be an efficient way, becasue the blog or some guidance information may not directly answer the assignment question. Even worse, programmers need to spend much time to filter the huge amount of information and it become hard for them to get answer when the homework question is not relavent to the results in website. Uploading question on Wechat group could get the detalied guidance and answer. But the new Wechat group will be created every semester for other students who may encounter the same problems. The connection between students already taken this course with the students taking this course right now is broken in this way. Rasing questions in office hour is not convenient for programmers to solve their question immediately since they need to make an appointment and wait until that day coming. Therefore, our group would like to take the first step to change the current situation. 

Based on the inspiration of public Q&A platform Stack-Overflow, our group think it is necessary to design a similar Q&A platform for programmers in CUHKSZ. It could help them solve their technical questions in time which could save their much time in finishing homework.  programmers could use this platform to browse their questions on website and they will get the relavent answer immediately since there are many students have already taken this course and they may encounter the similar problems. Also, the platform is more friendly. Programmers could use their nickname rather than true name and it is totally private for others. Therefore it would not make them shame about their questions. The platform also support many format of question, which means programmers could use code block to express their specific question rather than word. It is much efficient and clear to use code block to express their idea. So students could find the help on our website when they encounter some difficult bugs. 

Our group also want to build it as an social community for those programmmers who want to raise some intersting topic to discuss with others.  programmers will have a platform to share their learnning experience and their own suggtestions to those younger students. And this friendly environment will also encourage more programmers to  learn skills and be more creative and productive. 

In the view of above, our groups borrow the ideas from famous used app called Stack-Overflow in CS community, and we hope create a CUHKSZ version for programmers in our school. This website can be used to uploaded the questions relavent to their course homework, support user use code block to express their problem and specific need. The website also will ranking the high-quality answer and recommonded every member in this community to read in their homepage, which rasie interest for every community member to learn.  By knowing the drawback of current Q&A mode, hopefully this system can boost the motivation for programmers to rasie question and sovle question immediately in CUHKSZ. Thus, empower every CUHKSZer programming skill. 



## 3. Specification

We have divided our system into four main parts to show the data flow: User Login and Registration, User Search and match results, User upload questions, and Ranking System. This part of reports shows the data flow diagram and the description on the design specification of data flow and behaviour of thses four parts.

### 3.1 User Login and Registration



![截屏2022-03-02 下午3.23.05](/Users/huangpengxiang/Library/Application Support/typora-user-images/截屏2022-03-02 下午3.23.05.png)

Users will have to go over a user registration process before they could use our system. The user registration function is mainly for the programmer to personalized. To create an account, we require users to enter their email and password. A format validation check will be applied to ensure that the email format is like“xxx@xxx.xxx”. There would also be a data verification process that asks users to confirm their password by retyping in their desired password in another field. An email will be sent to the email account of the user afterwards and they are required to activate their account by clicking on the link provided in the confirmation email.
Users who did not login to the system could also view the contents of the pages. For those users who would like to post comments of menus, they will have to login by typing their email as username and their own password. If users have any login problems, our system provides a function for users to change their password. These users will be asked to type in their email for receiving an email, and in the email, they can click into a link to change password. By submitting the new password in the link, our database will update the user’s data in the password field.

After creating the account, we will provide various type for user to personalized their information. They are able to have a nickname and some basic information like courses already takne and courses taking right now, language preference, etc. This basic information is public, and other user have the access to see these information. This funciton mainly help user to recognize many friends who have the same preference, and it also will be used to invite people to deal with some specific problem. 

### 3.2 User search and match result

![截屏2022-03-02 下午3.52.21](/Users/huangpengxiang/Library/Application Support/typora-user-images/截屏2022-03-02 下午3.52.21.png)

When user try to Search some relevant information with its problem. The System will ask them to input the question content and the question type. The question type is defined by the system admin. The question type mainly include CSC3100, CSC3050, etc. The filter is composed of two parts. The first filter is course number like CSC3100, user could only pick one of those course number. The second filter is aboout the homework number, eg. project 1. By this filter, the user can search the content in detailed like CSC3100 project 1. 

The user are aslo could to upload the question content. The system will cut the word into different chunks. And the database system will search some of those chunks by some algorithm and present the most relevant blogs to user. user can search information by either the question content or question type. 

The database will use the input word chunk or course type to match the corresponding blog.  During the the match process, we will develop a matching algorithm to match the source information and target blogs. The first blog that is found will be present on the top, which will be regard as most relevant blog. The system will show all the relevant blogs. And user can filter those blogs by upload time, by most approved, etc.

### 3.3 User upload questions or answer

![截屏2022-03-02 下午4.08.45](/Users/huangpengxiang/Library/Application Support/typora-user-images/截屏2022-03-02 下午4.08.45.png)

When user try to rasie a question in the system, User have to determine which type the question is. The type include the course number like CSC3150. After user choose the type, they are required to type their question content. the content support many format such as markdown, word, text, code block, emoj, etc. Users feel free to type any question they want to ask within the type. The users will create the blog when user after finish the content, and the blog will be sent to the question databse system with users information. 

When user want to answer somebody's question. Their answer will just be put under the original question blog. And the informaiton will be stored into teh database system,  the course type of the answer will be the same as the question blog. The blog information will be displayed on the website for every user to see.

### 3.4 Ranking System

![截屏2022-03-02 下午4.21.10](/Users/huangpengxiang/Library/Application Support/typora-user-images/截屏2022-03-02 下午4.21.10.png)

The ranking system is used when there are many blogs in database system. All the blog information will be classified into many class by their type. In each type, the the ranking system will take some particular algorithm to rank all the blog information. The system will rank blogs by created time, most approved, most necessary question needed to be answer, etc. The system will display the result to the user and recommend them to read or answer question based on their background information. 