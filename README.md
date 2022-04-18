# CSC4001_Project
This is the CUHKSZ software engineering project. 

项目文件：

```bash
.
├── Code       // source code of both backend and frontend
├── Docs	   // Several Documents we wrote related to this project
├── fs		   // stores the files uploaded
├── pictures   
├── profiles
├── README.md
├── reset_backend.sh  // A bash script that reset the backend
└── uwsgi.log		  // error logs here
```

+ To get the up-to-state code, please run `git pull origin main`
+ When you change the source code, you can reset the whole project by `sh reset_backend.sh`


## Frontend Environment Configuration
if you want to run the code in local computer, you should configure your environment such below:

run the command `npm i font-awesome -S` in front end to install the package or some icons won't appear.  
To run the online-code editor `prismjs` on your own computer, you should run the following command:
`npm install prismjs`
`npm install babel-plugin-prismjs`
`npm install vue-prismjs-editor`
and add those following code on `.babelrc`
```
module.exports = {
  presets: ["@vue/cli-plugin-babel/preset"],
  plugins: [
    // 这块是增加的prismjs的配置
    [
      "prismjs",
      {
        languages: ["javascript", "css", "markup"],
        plugins: ["line-numbers"],
        theme: "okaidia",
        css: true
      }
    ]
  ]
};
```  
---
#### Testing  
 + You can try testing our Website using the test suites we provided by typing http://175.178.34.84/api/testing  
  + It will automatically do the Following testing:  
    + Unit Testing: includes 19 test files and over 70+ test cases
    + Component Testing: includes 6 test files and over 10 test cases
    + System Testing: includes 1 test files and 1 over-all test case 