<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
<title>방명록 등록</title>
   <style>
        .additional-table tr, .additional-table td {
           padding: 10px;
           text-align: center;
           border: 1px solid-collapse: collapse;
        }
        
        .additional-table tr:first-child {
           background-color: lightgray;
           border-top: 1px solid lightgray;
        }
       .additional-table tr:not(:first-child) {
           background-color: #0FB790;
        }
       .input_list {
	       border-collapse: collapse; 
	       table-layout: fixed; 
	       width: 80%; 
	       margin: 0 auto; 
	       top: 80px; 
	       position: relative;  
	       color: #0FB790; 
	       height: 200px;
        }
        .input_list tr, .input_list td{
           padding: 10px;
           text-align: center;
           border: 2px solid #757576;
           
        }
        .input_list tr:first-child{
           background-color: lightgray;
           border: 2px solid #757576;
        }
        .title {
           text-align: center;
           top: 30px;
           position: relative;
           font-weight: normal;
        }
        .button_ {
           width: 100px;
           height: 40px;
           background-color: #40A7F6;
           border-radius: 5px;
           color: white;
           font-size: 16px;
           font-weight: bold;
           border-style: solid;
           border-color: transparent;
           top: 160px;
           position: relative;
        }
         .input_button {
	         width: 110px;
	         height: 45px;
	         background-color: #40A7F6;
	         border-radius: 5px;
	         color: white;
	         font-size: 16px;
	         font-weight: bold;
	         border-style: solid;
	         border-color: transparent;
	         top: 130px;
	         position: relative;
        }
    </style>
    <script type="text/javascript">
        function validateForm() {
            var name = document.getElementsByName("name")[0].value;
            var email = document.getElementsByName("email")[0].value;
            var title = document.getElementsByName("title")[0].value;
            var password = document.getElementsByName("password")[0].value;
            var content = document.querySelector("textarea").value;
            
            if (name === "" || email === "" || title === "" || password === "" || content === "") {
              alert("입력란을 채워주세요.");
              event.preventDefault();
            }
        }
           
        function reset() {
            document.querySelector("form").reset();
        }
   </script>  
   </head>
      <body>
         <h1 class="title" >방명록 입력</h1>
         <div>
         <form method="post" action="/jwbook/weblog.nhn?action=addWeblog" enctype="multipart/form-data">
              <table class = "input_list" >
                 <tr>
                     <th>작성자</th>
                     <td>
                          <input type="text" name="name" class="form-control">
                      </td>
                 </tr>
                 <tr>
                     <td>이메일</td>
                     <td>
                        <input type="text" name="email" class="form-control">
                     </td>
                 </tr>
                 <tr>
                     <td>제  목</td>
                     <td>
                        <input type="text" name="title" class="form-control">
                     </td>
                 </tr>
                 <tr>
                     <td>비밀번호</td>
                     <td>
                        <input type="text" name="password" class="form-control">
                     </td>
                 </tr>    
              </table>
              <div>
                     <textarea class="noresize" style = "border: 10px solid lightgray; display: block; width: 80%; margin: 0 auto; top: 100px; position: relative;  height: 250px">${weblog.content}</textarea>
              </div>
	          <div class="input-button-container" style="display: flex; justify-content: center; align-items: center;">
	                 <button type="submit" class="input_button" style="margin-right: 30px;" onclick="validateForm()">입력</button>
	                 <button type="reset" class="input_button" onclick="reset()">취소</button>
	                 <button type="submit" class="input_button" style="margin-left: 30px;">목록</button>
	          </div>   
         </form> 
      </div>         
   </body>
</html>