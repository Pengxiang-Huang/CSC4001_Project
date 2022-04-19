# CSC4001_Project: CUHKSZ-Overflow

## Objective

Our project, CUHKSZ-Overflow, mainly aims to provide a Q&A platform for CUHKSZ programmers who have technical questions about their Computer Science courses' projects or assignments in CUHK(SZ).

**Our Team:**

- frontend: [Demario-Huang](https://github.com/Demario-Huang), [Andy-Lee](https://github.com/Andy-Account)

- backend:  [David-Qin](https://github.com/QinPR), [handsbro666](https://github.com/handsBro666)

If you have any issue about our project, feel free to raise up.

## Demo
You can see the demo on http://175.178.34.84/index/. 🤩

Notice that you need to use CUHKSZ email account, only valid `(student_id/staff)@link.cuhk.edu.cn` email will be accepted. 

Thanks for `Froala` and `Sphere engine` as a plug-in in this project. 

## Project Information
**File Tree:**

```bash
.
├── Code       // source code of both backend and frontend
├── Docs	   // Several Documents and specification
├── fs		   // stores the server files uploaded, used as a backup
├── pictures   // backup pics
├── profiles  // store users profiles, used as backup
├── README.md
├── reset_backend.sh  // A bash script that reset the backend
└── uwsgi.log		  // error logs here
```

+ To get the up-to-state code, please run `git pull origin main`
+ When you change the source code, you can reset the whole project by `sh reset_backend.sh` 

#### Try running frontend code.
The develop environment is: Vue2, so simply you should have  `Vue.js` `npm` `nodejs` in your local computer

+ git clone our code 

+ `cd Code/frontend`

+ npm install
+ npm run dev

#### Try running backend code.
The develop environment is: django, so you should have `python3`  `pip3` in your local environment to run the backend.

+ First, get into the backend directory:

+ `cd Code/backend`

+ Install all the dependencies package: 

+	`pip3 install -r requirements.txt`

+ Run on localhost:

+ `python3 manage.py runserver`

Our database use `mysql`, if you are intersted in, feel free to download our inital database.

---
#### Testing  
 + You can try testing our Website using the test suites we provided by typing http://175.178.34.84/api/testing  
  + It will automatically do the Following testing:  
    + Unit Testing: includes 19 test files and over 70+ test cases
    + Component Testing: includes 6 test files and over 10 test cases
    + System Testing: includes 1 test files and 1 over-all test case 
