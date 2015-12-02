## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Calvyn82/stp. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

# Getting Vagrant up and running

The Vagrant build is designed to allow users on systems not conducive to developing in Rails, namely Microsoft Windows, to participate. To that end, we've greated a Vagrant box for getting the app up and running. If you need to develop in vagrant, get in contact with us to get a copy of the box.

You use vagrant to set up and run a virtual machine, so you'll need to allow for at least 2GB of space.

You'll need to install [Vagrant](http://www.vagrantup.com/downloads.html) and [Virtualbox](https://www.virtualbox.org/wiki/Downloads) for whatever operating system you are using.

Once you have the box file, place it in the root directory of your locally cloned stp repo.

Navigate to the app's root directory and type:

`vagrant up`.

This will install the Vagrant build for you.

Once that is completed, you can ssh in to the Vagrant Box by typing:

`vagrant ssh` 

Once you're in the Vagrant shell, navigate to the rails app with:

`cd /vagrant`

## License

The code is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
