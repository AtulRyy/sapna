const express=require('express')
const app=express();

app.get('/',(req,res)=>{
    const respons={name:'atul',class:'4'};
    res.json(respons);
})

app.listen(3000,()=>{
    console.log("Server Listening at port 3000");
})