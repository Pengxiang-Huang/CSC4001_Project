# CSC4001_Project
This is the CUHKSZ software engineering project. 

run the command `npm i font-awesome -S` in front end to install the package or some icons won't appear.  

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
