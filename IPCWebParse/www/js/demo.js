var exQueries = [ '` sv `hello`world', '1 + 1' ,'metaData[]' , '([] a: til 10)', '([] time:10?.z.t; sym:10?`3; prx:10?100f; sz:10?10000)' , '\\\\ps faux'];

$(document).ready(function(){
  $("#query").keyup(function(event){
    if(event.keyCode == 13)
      $("#btnExecQuery").click();
  });
  addExamples();
});

function addExamples(){
  hintDiv = $("#hint");
  hintDiv.append("<ul>")
  for(var i = 0; i < exQueries.length; i++){
    html = "<li><a href=\"#\" onclick=\"setAndExecInput('"+exQueries[i]+"')\">"+exQueries[i]+"</a></li>";
    $("#hint").append(html);
  };
  hintDiv.append("</ul>");
};

function setAndExecInput(query){
  $("#query").val(query);
  execInputQuery();
 };
function execQuery(query){
  console.log("Executing query: "+query);

  url = "/ipc?"+query;
  console.log("URL: "+url);

  $.get(url, function(data,status){
    console.log("GET status: "+status);
    ipc = data;
    res = deserialize(ipcstr2arraybuffer(data));
    console.log(res);
    $("#result").text(JSON.stringify(res,null,4));
  });
};

function execInputQuery(){
  query = $("#query").val();
  if(query.length == 0){
    alert("Input query is empty");
    $("#result").text("");
    return;
  };
    
  execQuery(query);
};

