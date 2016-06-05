Puppet::Type.newtype(:xld_infra) do

  desc = "This type is created to have a node added to xldeploy"


  # xld_infra { "xldnode01.test.lan":
  #   xld_server      => Servername or Ipnumer of xldeploy server (eg. xldeploy1.test.lan),
  #   xld_port        => 4516,
  #   xld_api_usr     => username to use when connecting to xldeploy server
  #   xld_api_pwd     => password to use when connecting to xldeploy server
  #   infra_name      => hostname (fqdn) of infra node (=namevar)
  #   infra_path      => Path to the node (eg. Infrastructure/CEHC/02 CEHC-TST/)
  #   os              => UNIX, WINDOWS, ZOS
  #   conn_type       => SFTP,SFTP_CYGWIN,SFTP_WINSSHD,SCP, SU, SUDO, INTERACTIVE_SUDO
  #   address         => <ipnumber/hostname of node>
  #   ssh_port        => port on which SSH server runs (eg. 22)
  #   username        => Username to use for ssh authentication
  #   password        => Password to use for ssh authentication
  #   private_keyfile => Privatekey file to use for authentication
  #   passphrase      => Optional passphrase for the privatekey  in the privatekey file
  #   temp_dir        => directory into which temporary files are stored
  #   staging_dir     => directory into which staging files are stored
  #   satelite        => unknown, satelite server for xldeploy
  #   jumpstation     => infrastructure machine of type: overthere.SshJumpstation
  #   sudo_usr        => username to sudo to
  #   su_usr          => username to su to
  #   su_pwd          => password for su
  # }

  # Make sure we can ensure => present/absent
  ensurable

  # Global validation
  validate do
    fail('xld_server parameter is required when ensure is present/absent') if ((self[:ensure] == :present) or (self[:ensure] == :absent))  and self[:xld_server].nil?
    fail('xld_port parameter is required when ensure is present/absent') if ((self[:ensure] == :present) or (self[:ensure] == :absent)) and self[:xld_port].nil?
    fail('xld_api_usr parameter is required when ensure is present/absent') if ((self[:ensure] == :present) or (self[:ensure] == :absent)) and self[:xld_api_usr].nil?
    fail('xld_api_pwd parameter is required when ensure is present/absent') if ((self[:ensure] == :present) or (self[:ensure] == :absent)) and self[:xld_api_pwd].nil?

  end

  # Define the xldeploy server or ipnumber
  newparam(:xld_server) do
    desc 'The xldeploy servername or ip we should connect to (Note: must be resolvable.'
  end

  # Define the xldeploy server port (default: 4516)
  newparam(:xld_port) do
    desc 'The xldeploy server port can connect to (default: 4516).'
  end

  # The loginname for the xldeploy api
  newparam(:xld_api_usr) do
    desc 'The api username to connect to the xldeploy server'
  end

  # The password for the xldeploy api user
  newparam(:xld_api_pwd) do
    desc 'The api user password to connect to the xldeploy server'
  end

  # The infrastructure name is the namevar
  newparam(:infra_name, :namevar => true) do
    desc 'An arbitrary name used as the identity of the resource.'
  end

  # Properties:
  # We can discover or update this, so we use a property!

  # The path in xldeploy
  newproperty(:infra_path) do
    desc 'The path in the xldeploy webinterface (eg. Infrastructure/CEHC/02 CEHC-TST/)'
  end


  # The hostname or ipadress of the node
  newproperty(:address) do
    desc 'The hostname (or ipnumber) of the node'
  end

  # The ssh_port of the node to connect to
  newproperty(:ssh_port) do
    desc 'The tcp port of the SSH service, the node uses'
  end


  # We can choose from 3 values for the OS property
  newproperty(:os) do
    desc 'The OS parameter must be one of the following: UNIX,WINDOWS,ZOS'

    defaultto :UNIX
    newvalues(:UNIX, :WINDOWS, :ZOS)
  end

  # The connectiontype to use
  newproperty(:conn_type) do
    desc 'The connection type that xldeploy should use (SFTP,SFTP_CYGWIN,SFTP_WINSSHD,SCP, SU, SUDO or INTERACTIVE_SUDO)'

    defaultto :SCP
    newvalues(:SFTP, :SFTP_CYGWIN, :SFTP_WINSSHD, :SCP, :SU, :SUDO, :INTERACTIVE_SUDO)
  end

  # The ssh username
  newproperty(:username) do
    desc 'The username that is used for ssh logins'
  end

  # The ssh password for :username
  newproperty(:password) do
    desc 'The password for the username that is used for ssh logins'
  end

  # The ssh publickey file
  newproperty(:privateKeyFile) do
    desc 'The absolute full path to the ssh public key'
  end
end
