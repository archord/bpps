/**
* @ Author:Lanlin
*/
var e={
    isIE:(document.all)?true:false,
	//初始化
	init:function(){
        //this.showCover();
		//setInterval("e.showCoverRecover()",1000);

    },

    //选择器
    $:function(id){
        return document.getElementById(id);
    },

    //显示/隐藏制定ID
    hidNode:function(id){
        var obj=document.getElementById(id);
        if(obj.style.display=='none'){
		  obj.style.display='';
		  return true;//表示当前为block状况
	   }else{
		  obj.style.display='none';
		  return false;//表示当前为none状况
	   }
    } ,

	//给name为bt的按钮加事件
	btEvent:function(){
		var objs=document.getElementsByName('bt');
		for(var i=0;i<objs.length;i++){
			if(objs[i].type="button"){
				objs[i].className="bt";
				objs[i].onmouseover=function(){this.className='bt2'};
				objs[i].onmouseout=function(){this.className='bt'};
			}
		}
	},

	//=====扩展区开始(注意函数结束后要加逗号进行分隔)，见下helloworld示例============================
	/**
	 * @author:兰林
	 * action:示例
	 * */
	helloWorld:function(){
		alert("hello world!");
	},
	/**
	 * @author:兰林
	 * action:返回上一页
	 * */
	back:function(){
		history.go(-1);
	},
	/*前往url*/
	go:function(url){
		window.location=url;
	},







	//=====扩展区结束=======================================================================

	//页面load over 后触发
	loadOK:function(){
		//

		this.btEvent();


	}
};

window.onload=function(){e.loadOK();};

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//结束
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/*
 * 日历
 * */
function PopupCalendar(InstanceName)
{
 ///Global Tag
 this.instanceName=InstanceName;
 ///Properties
 this.separator="-"
 this.oBtnTodayTitle="Today"
 this.oBtnCancelTitle="Cancel"
 this.weekDaySting=new Array("S","M","T","W","T","F","S");
 this.monthSting=new Array("January","February","March","April","May","June","July","August","September","October","November","December");
 this.Width="200px";
 this.currDate=new Date();
 this.today=new Date();
	this.startYear=1910;

	var date=new Date();
	this.endYear=date.getFullYear();

 this.normalfontColor="#666666";
 this.selectedfontColor="red";
 this.divBorderCss="1px solid #BCD0DE";
 this.titleTableBgColor="#98B8CD";
 this.tableBorderColor="#CCCCCC"
 ///Css
 this.normalfontColor="#666666";
 this.selectedfontColor="red";
 this.divBorderCss="1px solid #BCD0DE";
 this.titleTableBgColor="#98B8CD";
 this.tableBorderColor="#CCCCCC"
 ///Method
 this.Init=CalendarInit;
 this.Fill=CalendarFill;
 this.Refresh=CalendarRefresh;
 this.Restore=CalendarRestore;
 ///HTMLObject
 this.oTaget=null;
 this.oPreviousCell=null;
 this.sDIVID=InstanceName+"_Div";
 this.sTABLEID=InstanceName+"_Table";
 this.sMONTHID=InstanceName+"_Month";
 this.sYEARID=InstanceName+"_Year";
 this.sTODAYBTNID=InstanceName+"_TODAYBTN";
 this.sIFRAMEID=InstanceName+"_IFrame";//Edmond

}
function CalendarInit()    ///Create panel
{
 var sMonth,sYear
 sMonth=this.currDate.getMonth();
 sYear=this.currDate.getYear();
 htmlAll=""
 htmlAll+="<iframe id='"+this.sIFRAMEID+"' src='javascript:false;' scrolling='no' frameborder='0' style='position:absolute;width:"+this.Width+";height:220px;display:none;'></iframe>";//Edmond
 htmlAll+="<div id='"+this.sDIVID+"' style='display:none;position:absolute;width:"+this.Width+";border:"+this.divBorderCss+";padding:2px;background-color:#FFFFFF;z-index:100'>";
 htmlAll+="<div align='center'>";
 /// Month
 htmloMonth="<select id='"+this.sMONTHID+"' onchange=CalendarMonthChange("+this.instanceName+") style='width:50%'>";
 for(i=0;i<12;i++)
 {
  htmloMonth+="<option value='"+i+"'>"+this.monthSting[i]+"</option>";
 }
 htmloMonth+="</select>";
 /// Year
 htmloYear="<select id='"+this.sYEARID+"' onchange=CalendarYearChange("+this.instanceName+") style='width:50%'>";
 for(i=this.startYear;i<=this.endYear;i++)
 {
  htmloYear+="<option value='"+i+"'>"+i+"</option>";
 }
 htmloYear+="</select></div>";
 /// Day
 htmloDayTable="<table id='"+this.sTABLEID+"' width='100%' border=0 cellpadding=0 cellspacing=1 bgcolor='"+this.tableBorderColor+"' style='font-family:Arial, Helvetica, sans-serif'>";
 htmloDayTable+="<tbody bgcolor='#ffffff'style='font-size:9pt'>";
 for(i=0;i<=6;i++)
 {
  if(i==0)
   htmloDayTable+="<tr bgcolor='" + this.titleTableBgColor + "'>";
  else
   htmloDayTable+="<tr>";
  for(j=0;j<7;j++)
  {

   if(i==0)
   {
    htmloDayTable+="<td height='20' align='center' valign='middle' style='cursor:hand'>";
    htmloDayTable+=this.weekDaySting[j]+"</td>"
   }
   else
   {
    htmloDayTable+="<td height='20' align='center' valign='middle' style='cursor:hand'";
    htmloDayTable+=" onmouseover=CalendarCellsMsOver("+this.instanceName+")";
    htmloDayTable+=" onmouseout=CalendarCellsMsOut("+this.instanceName+")";
    htmloDayTable+=" onclick=CalendarCellsClick(this,"+this.instanceName+")>";
    htmloDayTable+="&nbsp;</td>"
   }
  }
  htmloDayTable+="</tr>";
 }
 htmloDayTable+="</tbody></table>";
 /// Today Button
 htmloButton="<div align='center' style='padding:3px'>"
 htmloButton+="<button id='"+this.sTODAYBTNID+"' style='width:40%;border:1px solid #BCD0DE;background-color:#eeeeee;cursor:hand'"
 htmloButton+=" onclick=CalendarTodayClick("+this.instanceName+")>"+this.oBtnTodayTitle+"</button>&nbsp;"
 htmloButton+="<button style='width:40%;border:1px solid #BCD0DE;background-color:#eeeeee;cursor:hand'"
 htmloButton+=" onclick=CalendarCancel("+this.instanceName+")>"+this.oBtnCancelTitle+"</button> "
 htmloButton+="</div>"
 /// All
 htmlAll=htmlAll+htmloMonth+htmloYear+htmloDayTable+htmloButton+"</div>";
 document.write(htmlAll);
 this.Fill();
}
function CalendarFill()   ///
{
 var sMonth,sYear,sWeekDay,sToday,oTable,currRow,MaxDay,iDaySn,sIndex,rowIndex,cellIndex,oSelectMonth,oSelectYear
 sMonth=this.currDate.getMonth();
 sYear=this.currDate.getYear();
 sWeekDay=(new Date(sYear,sMonth,1)).getDay();
 sToday=this.currDate.getDate();
 iDaySn=1
 oTable=document.all[this.sTABLEID];
 currRow=oTable.rows[1];
 MaxDay=CalendarGetMaxDay(sYear,sMonth);

 oSelectMonth=document.all[this.sMONTHID]
 oSelectMonth.selectedIndex=sMonth;
 oSelectYear=document.all[this.sYEARID]
 for(i=0;i<oSelectYear.length;i++)
 {
  if(parseInt(oSelectYear.options[i].value)==sYear)oSelectYear.selectedIndex=i;
 }
 ////
 for(rowIndex=1;rowIndex<=6;rowIndex++)
 {
  if(iDaySn>MaxDay)break;
  currRow = oTable.rows[rowIndex];
  cellIndex = 0;
  if(rowIndex==1)cellIndex = sWeekDay;
  for(;cellIndex<currRow.cells.length;cellIndex++)
  {
   if(iDaySn==sToday)
   {
    currRow.cells[cellIndex].innerHTML="<font color='"+this.selectedfontColor+"'><i><b>"+iDaySn+"</b></i></font>";
    this.oPreviousCell=currRow.cells[cellIndex];
   }
   else
   {
    currRow.cells[cellIndex].innerHTML=iDaySn;
    currRow.cells[cellIndex].style.color=this.normalfontColor;
   }
   CalendarCellSetCss(0,currRow.cells[cellIndex]);
   iDaySn++;
   if(iDaySn>MaxDay)break;
  }
 }
}
function CalendarRestore()     /// Clear Data
{
 var i,j,oTable
 oTable=document.all[this.sTABLEID]
 for(i=1;i<oTable.rows.length;i++)
 {
  for(j=0;j<oTable.rows[i].cells.length;j++)
  {
   CalendarCellSetCss(0,oTable.rows[i].cells[j]);
   oTable.rows[i].cells[j].innerHTML="&nbsp;";
  }
 }
}
function CalendarRefresh(newDate)     ///
{
 this.currDate=newDate;
 this.Restore();
 this.Fill();
}
function CalendarCellsMsOver(oInstance)    /// Cell MouseOver
{
 var myCell = event.srcElement;
 CalendarCellSetCss(0,oInstance.oPreviousCell);
 if(myCell)
 {
  CalendarCellSetCss(1,myCell);
  oInstance.oPreviousCell=myCell;
 }
}
function CalendarCellsMsOut(oInstance)    ////// Cell MouseOut
{
 var myCell = event.srcElement;
 CalendarCellSetCss(0,myCell);
}
function CalendarYearChange(oInstance)    /// Year Change
{
 var sDay,sMonth,sYear,newDate
 sDay=oInstance.currDate.getDate();
 sMonth=oInstance.currDate.getMonth();
 sYear=document.all[oInstance.sYEARID].value
 newDate=new Date(sYear,sMonth,sDay);
 oInstance.Refresh(newDate);
}
function CalendarMonthChange(oInstance)    /// Month Change
{
 var sDay,sMonth,sYear,newDate
 sDay=oInstance.currDate.getDate();
 sMonth=document.all[oInstance.sMONTHID].value
 sYear=oInstance.currDate.getYear();
 newDate=new Date(sYear,sMonth,sDay);
 oInstance.Refresh(newDate);
}
function CalendarCellsClick(oCell,oInstance)
{
 var sDay,sMonth,sYear,newDate
 sYear=oInstance.currDate.getFullYear();
 sMonth=oInstance.currDate.getMonth();
 sDay=oInstance.currDate.getDate();
 if(oCell.innerText!=" ")
 {
  sDay=parseInt(oCell.innerText);
  if(sDay!=oInstance.currDate.getDate())
  {
   newDate=new Date(sYear,sMonth,sDay);
   oInstance.Refresh(newDate);
  }
 }
 sDateString=sYear+oInstance.separator+CalendarDblNum(sMonth+1)+oInstance.separator+CalendarDblNum(sDay);  ///return sDateString
 if(oInstance.oTaget.tagName.toLowerCase()=="input")oInstance.oTaget.value = sDateString;
 CalendarCancel(oInstance);
 return sDateString;
}
function CalendarTodayClick(oInstance)    /// "Today" button Change
{
 oInstance.Refresh(new Date());
 //Edmond
 sDateString=oInstance.currDate.getFullYear()+oInstance.separator+CalendarDblNum(oInstance.currDate.getMonth()+1)+oInstance.separator+CalendarDblNum(oInstance.currDate.getDate());  ///return sDateString
 if(oInstance.oTaget.tagName.toLowerCase()=="input")oInstance.oTaget.value = sDateString;
 CalendarCancel(oInstance);
 return sDateString;
}
function getDateString(oInputSrc,oInstance)
{
 if(oInputSrc&&oInstance)
 {
  var CalendarDiv=document.all[oInstance.sDIVID];
  oInstance.oTaget=oInputSrc;
  CalendarDiv.style.pixelLeft=CalendargetPos(oInputSrc,"Left");
  CalendarDiv.style.pixelTop=CalendargetPos(oInputSrc,"Top") + oInputSrc.offsetHeight;
  CalendarDiv.style.display=(CalendarDiv.style.display=="none")?"":"none";
  //Edmond
  var CalendarIFrame=document.all[oInstance.sIFRAMEID];
  CalendarIFrame.style.pixelLeft=CalendargetPos(oInputSrc,"Left");
  CalendarIFrame.style.pixelTop=CalendargetPos(oInputSrc,"Top") + oInputSrc.offsetHeight;
  CalendarIFrame.style.display=(CalendarIFrame.style.display=="none")?"":"none";
 }
}
function CalendarCellSetCss(sMode,oCell)   /// Set Cell Css
{
 // sMode
 // 0: OnMouserOut 1: OnMouseOver
 if(sMode)
 {
  oCell.style.border="1px solid #5589AA";
  oCell.style.backgroundColor="#BCD0DE";
 }
 else
 {
  oCell.style.border="1px solid #FFFFFF";
  oCell.style.backgroundColor="#FFFFFF";
 }
}
function CalendarGetMaxDay(nowYear,nowMonth)   /// Get MaxDay of current month
{
 var nextMonth,nextYear,currDate,nextDate,theMaxDay
 nextMonth=nowMonth+1;
 if(nextMonth>11)
 {
  nextYear=nowYear+1;
  nextMonth=0;
 }
 else
 {
  nextYear=nowYear;
 }
 currDate=new Date(nowYear,nowMonth,1);
 nextDate=new Date(nextYear,nextMonth,1);
 theMaxDay=(nextDate-currDate)/(24*60*60*1000);
 return theMaxDay;
}
function CalendargetPos(el,ePro)    /// Get Absolute Position
{
 var ePos=0;
 while(el!=null)
 {
  ePos+=el["offset"+ePro];
  el=el.offsetParent;
 }
 return ePos;
}
function CalendarDblNum(num)
{
 if(num < 10)
  return "0"+num;
 else
  return num;
}
function CalendarCancel(oInstance)   ///Cancel
{
 var CalendarDiv=document.all[oInstance.sDIVID];
 CalendarDiv.style.display="none";
 //Edmond
 var CalendarIFrame=document.all[oInstance.sIFRAMEID];
 CalendarIFrame.style.display="none";
}


var oCalendarChs=new PopupCalendar("oCalendarChs");	//初始化控件时,请给出实例名称:oCalendarChs
oCalendarChs.weekDaySting=new Array("日","一","二","三","四","五","六");
oCalendarChs.monthSting=new Array("一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月");
oCalendarChs.oBtnTodayTitle="今天";
oCalendarChs.oBtnCancelTitle="取消";
oCalendarChs.Init();

//example:getDateString(this,oCalendarChs)
//==========================================================================================================================

/**
 * 获取楼栋号
 */
 function getLou(){

 	var ldnum = document.getElementById("loudong");
 	var legend = document.getElementsByTagName("legend");
 	legend[0].innerHTML=ldnum.options[ldnum.options.value].text+"栋考勤";


 }

 /**
  * 获取考勤表格
  * @param {} year
  * @param {} month
  */
 var myDate = new Date();
var day = myDate.getDate();
 function getTable(year,month){
	clearTable();
	document.getElementById("time").innerHTML="考勤时间："+year+"-"+month;
 	days =getDaysOfMonth(parseInt(year),parseInt(month));

 	createTable(days,year,month);

 	addTr(days);
 }

 /**
  * 根据选择框获取时间
  *
  */

 function getTime(){

 	var year,month,days;
 	var years = document.getElementById("year");
 	var months = document.getElementById("month");


 	year=years.options[years.options.value].text;
 	month= months.options[months.options.value].text;

 	getTable(year,month);

 }

 /**
  * 添加商铺记录
  * @param {} days
  */

 function addTr(days){



 	var	tbody = document.getElementById("tbody");

 	for(var i=0;i<10;i++){

 		var tr = document.createElement('tr');
 		for(var j=0;j<days+3;j++){
 			 var td = document.createElement('td');
 			 if(j==0){
 			 	td.innerHTML=101+i;

 			 }
 			 else if((j-days)==1){
 			 	td.setAttribute('id','qq'+i)
  	  	td.innerHTML=days;
  	}else if((j-days)==2){
  		td.setAttribute('id','cq'+i)
  	 	 td.innerHTML=0;

  	}else{
  			 td.setAttribute('attr',i);
 			 td.innerHTML='&nbsp;'
 			 td.onclick= function(){change(this)};


 			 }
 			tr.appendChild(td);

 		}
 		tbody.appendChild(tr);
 	}

 }

 /**
  * 生成考勤表第一行
  *
  * @param {} days
  */
 function createTable(days,year,month){




 	var	tbody = document.getElementById("tbody");


 	var tr = document.createElement('tr');

 	for(var i=0;i<days+3;i++){

     var td = document.createElement('td');

 	 if(i==0){
 	 td.innerHTML="商铺编号/日期";

  	}else if((i-days)==1){
  	  td.innerHTML="缺勤天数";
  	}else if((i-days)==2){
  	  td.innerHTML="出勤天数";

  	}else{
      td.innerHTML=i;

       if(i==day&&year==myDate.getYear()&&month==myDate.getMonth()+1){
       	td.style.backgroundColor="#EB6203";
       }
    }

     tr.appendChild(td);

     }

      tbody.appendChild(tr);
 }

 /**
  *
  * 每次获取表格前清除前面的
  */

		function clearTable()
	{

    	var tBody = document.getElementById('tbody');


　　　while(tBody.childNodes.length>0)

　　　　{

　　　　　tBody.removeChild(tBody.firstChild);
　　　　}

    }

 /**
  *
  * 获取系统时间并生成表格
  */

function getSysTime(){


	getTable(myDate.getYear(),myDate.getMonth()+1);


}

/**
 * 检查闰年还是平年
 * @param {} year
 * @return {Boolean}
 */
function checkYears(year)
{
 if(year%4==0)
 {
  if(year%100==0)
  {
   return true;
  }
 }
 else if(year%400==0)
 {
  return true;
 }
 else
 {
  return false;
 }
}

/**
 * 获取某年某月的天数
 * @param {} years
 * @param {} month
 * @return {}
 */
function getDaysOfMonth(years,month)
{
 var months=[31,28,31,30,31,30,31,31,30,31,30,31];
 if(checkYears(years))
 {
  months[1]=29;
 }
 return months[month-1]; //返回次月的天数
}
/**
 * 考勤单元格变化
 *
 */

function change(td)
{
	var i = td.getAttribute("attr");
var qq = document.getElementById('qq'+i);
var cq = document.getElementById('cq'+i);

	if(td.innerHTML!='√'){
    td.innerHTML='√';

	if(qq.innerHTML>0){
		qq.innerHTML--;
		cq.innerHTML++;
	}

}
else if(td.innerHTML!='&nbsp'){
    td.innerHTML='&nbsp';
    qq.innerHTML++;
		cq.innerHTML--;
	}


}




