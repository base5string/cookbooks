node.default[:shi_mysql][:Server] = {
  :Port     => "3306",
  :ServerId => "10",
  :ConfDir  => "/etc/mysql",
  :Root     => {
    :Name   => "root",
    :Passwd => "nin1435"
  }
}

#node.default[:shi_mysql][:ReplicaSets] = [
#  {
#    :Master => {
#      :Host     => "localhost",
#      :Port     => "3306",
#      :ServerId => "10"
#    },
#    :Slaves => [
#      {
#        :Host     => "localhost",
#        :ServerId => "11"
#      }
#    ]
#  }
#]

