<HTML>
<HEAD>
<TITLE>My Web Site</TITLE>
</SCRIPT>
<BODY bgcolor="black" onLoad=Elastic()>
<CENTER>
<br><br><br><br>
<br><br><br><br>
<font color="green"><h2>This WebServer Build by</h2>
<font color="gold"><H1 ID="elastic" ALIGN="Center">ANSIBLE</H1>
Server Host Name : {{ ansible_hostname }}<br>
Server OS Family : {{ ansible_os_family }}<br>
IP Address of this Server: {{ ansible_default_ipv4.address }}<br>
{{ uptime.stdout }}
</body>
</HTML>
