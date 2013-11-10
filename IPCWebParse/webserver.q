if[0=system"p"; system"p 0W"];                                                / Listen on random port if not give -p arg
.h.HOME:system["pwd"][0],"/www";                                              / Set web root directory

LOG:{-1 " " sv(string[.z.p];$[10h=t:type x;x;.Q.s1 x]);}                      / Console logging function

.web.queryTypeSep:"?";                                                        / Seperator in /ipc?<query>
.web.oldzph:.z.ph;                                                            / Backup currrent .z.ph

.web.getQueryType:{[sep;uri]                                                  / Get "ipc" part of /ipc?<query>
  :$[sep in uri;first sep vs uri;0#""];
 };

.web.getQuery:{[sep;uri]                                                      / Get <query> part of /ipc?<query>
  :$[sep in uri;(1+uri?sep)_uri;0#""];
 };

.web.zphHandlers.ipc:{[uri;header]                                            / Define a handler for "ipc" query type
  LOG"Got IPC request uri is: ",uri;
  query:.web.getQuery[.web.queryTypeSep]uri;
  LOG"Query is: ",query;

  errHndlr:{:"Error executing query in ipc handler. Error was: ", x};
  :.h.hy[`txt;raze string -8!@[get;query;errHndlr]];
 };

.web.zphHandlers:` _ .web.zphHandlers;                                        / Drop null key from namespace to get true dictionary

.web.getBaseUrl:{                                                             / Gives us "http://<hostname>:<port>"
  :"http://",string[.Q.host .z.a],":",string[system"p"];
 };

.z.ph:.web.ph:{[x]                                                            / Define new .z.ph to handle our custom query types
  uri:.h.uh x 0;
  header: x 1;

  queryType:`$.web.getQueryType[.web.queryTypeSep]uri;
  if[queryType in key .web.zphHandlers;
    :.web.zphHandlers[queryType][uri;header];
  ];

  / delegate to original .z.ph if we don't match a query type
  :.web.oldzph[x];
 };

metaData:{                                                                    / A function to facilitate web demo
  out:()!();
  out[`args]:.z.x;
  out[`bootScript]:.z.f;
  out[`kdbVersion]:`major`minor!(.z.K;.z.k);
  out[`host]:.z.h;
  out[`port]:system"p";
  out[`currentTime]:.z.p;
  out[`pid]:.z.i;
  out[`user]:.z.u;
  out[`os]:.z.o;
  :out;
 };

-1"\r\r\r\t Go to: ",.web.getBaseUrl[],"/index.html";                         / Print this servers url to console
