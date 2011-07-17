LOG:{show x};

args:.Q.def[(!) . flip (
	(`hostname	;	`);
	(`username	;	`);
	(`debug		;	1b)
  );
 ] .Q.opt .z.x;

DEBUG:$[args[`debug]; {LOG x};{}];

/ssh cmd args
sshargs:(!) . flip (
	enlist	(`o	;	`$("StrictHostKeyChecking=no";"BatchMode=yes"))
 );

/Function which executes commands, either remotely or locally.
/If [host] arg is null, we assume we're working locally
executor:{[cmd;host;user]
	sshcmd:"ssh ",sv[" ";raze each "- ",'/:string raze (cross).'flip (key;get)@\:#[;mysshargs] where not all each null mysshargs:(),/: sshargs,(!).(),/:`l,user], " ",string[host]," ";
	cmdprefix:$[null host;"";sshcmd];
	DEBUG cmdprefix,cmd;
	@[system;cmdprefix,cmd;{[cmd;err] DEBUG["Unable to execute command [ ",cmd," ]. Error was [ ",err," ]"];'err}[cmd]]
 };

/Generic parsers
.parsers.cpuinfo:{(!) .' flip each ({`$first x};{v:2_raze 1_x;@[get;v;{.[$;(`;x);{`NULL}]}[v]]})@\:/:/:"\t" vs'/: -1_' (0N;1+x?"")#x};
.parsers.meminfo:{(`$;{v:ltrim ssr[x;" kB";""]; @[get;v;{.[$;("J";x);{0}]}[v]]})@'/:":" vs'x};
.parsers.df:{flip $[`;first tmp]!"SJJJSS"$'flip 1_tmp:6#'ltrim each (0,'where each 1=/:deltas each " "=/:x)_'x};
