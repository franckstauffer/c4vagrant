c4vagrant
=========

This project helps you in getting RBS Change 4 up and running using [Vagrant](http://www.vagrantup.com/) 1.3.5 or above 
and [Virtualbox](https://www.virtualbox.org/) 4.3.0 or above. Assuming you've got vagrant and virtualbox already setup, 
it is as simple as : 

1. Cloning this project
2. Run `vagrant box add precise https://oss-binaries.phusionpassenger.com/vagrant/boxes/latest/ubuntu-14.04-amd64-vbox.box` 
2. Run `vagrant up` at the root of the freshly cloned project
3. Wait for the script to finish

After that a fresh RBS Change install will be deployed and will be running on [http://localhost:8888/admin.php](http://localhost:8880/admin.php)
