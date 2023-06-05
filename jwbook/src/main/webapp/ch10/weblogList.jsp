<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>방명록 목록</title>
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
</head>
<body>
    <h1 class="title">방명록 목록</h1>
       <div>
       <table class="additional-table" style = "table-layout: fixed; width: 90%; margin: 0 auto; border: 2px solid #0FB790; top: 80px; position: relative;">
           <tr style="background-color: lightgray; border-top: 1px solid lightgray; ">
               <th>번호</th>
               <th>작성자</th>
               <th>이메일</th>
               <th>작성일</th>
               <th>제목</th>
           </tr>
           <c:forEach var="weblog" items="${webloglist}" varStatus="status">
                 <tr style="background-color: lightgray; border-top: 1px solid lightgray;">
                     <td>${status.count}</td>
                     <td>${weblog.name}</td>
                     <td>${weblog.email}</td>
                     <td>${weblog.date}</td>
                     <td><a href="weblog.nhn?action=editWeblog&aid=${weblog.aid}" class="text-decoration-none">${weblog.title}</a></td>
                 </tr>
         </c:forEach>
       </table>
   </div>
   <div>
      <form method="post" action="/jwbook/weblog.nhn?action=showNewsPut" enctype="multipart/form-data">
          <button class="button_" style="display: block; margin: 0 auto;">등록</button>
      </form>
   </div>
   </body>
</html>