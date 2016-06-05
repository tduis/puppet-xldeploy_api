# Provider for Linux to create xld deploy infrastructure 
Puppet::Type.type(:xld_infra).provide(:linux) do
  confine :kernel => 'Linux'


  commands :curl => 'curl'

  def exists?
    begin
      File.exist? "/var/tmp/#{resource[:name]}.xml"
      true
    rescue Puppet::ExecutionFailure => e
      false
    end
  end

  def create
    begin
     # First we need to create the resource[:xld_infra] xml file
     fp=File.open("/tmp/#{resource[:xld_infra]}.xml", 'w')
     fp.write("<overthere.SshHost id='#{resource[:infra_path]}/#{resource[:xld_infra]}'\n")
     fp.write("  <tags/>\n")
     fp.write("  <os>#{os}</os>\n")
     fp.write("  <temporaryDirectoryPath>/tmp</temporaryDirectoryPath>\n")
     fp.write("  <connectionType>SCP</connectionType>\n")
     fp.write("  <address>#{ipaddress}</address>\n")
     fp.write("  <port>#{ssh_port}</port>\n")
     fp.write("  <username>xldeploy</username>\n")
     fp.write("  <privateKeyFile>/home/xldeploy/.ssh/id_rsa</privateKeyFile>\n")
     fp.write("  <sudoUsername>xldeploy</sudoUsername>\n")
     fp.write("  \n")
     fp.write("</overthere.SshHost>\n")
     fp.close

#<overthere.SshHost id="Infrastructure/CEHC/02 CEHC-TST/cehca003.test.lan">
#  <tags/>
#  <os>UNIX</os>
#  <temporaryDirectoryPath>/tmp</temporaryDirectoryPath>
#  <connectionType>SCP</connectionType>
#  <address>172.30.20.38</address>
#  <port>22</port>
#  <username>xldeploy</username>
#  <privateKeyFile>/home/xldeploy/.ssh/id_rsa</privateKeyFile>
#  <sudoUsername>xldeploy</sudoUsername>
#</overthere.SshHost>


    end
  end
end
