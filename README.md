c4vagrant
=========

This project helps you in getting RBS Change 4 up and running using [Vagrant](http://www.vagrantup.com/) 1.3.5 or above 
and [Virtualbox](https://www.virtualbox.org/) 4.3.0 or above. Assuming you've got vagrant and virtualbox already setup, 
it is as simple as : 

1. Cloning this project
2. Run `vagrant up` at the root of the freshly cloned project
3. Run `vagrant ssh` to connect to the VM
4. Go to `/vagrant/provisioning` and run `sudo bash c4.sh`
5. Wait for the script to finish

After that a fresh RBS Change install will be deployed and will be running on [http://localhost:8080/admin.php](http://localhost:8080/admin.php)
