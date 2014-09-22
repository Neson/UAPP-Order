UAPP - Order
==============

訂購系統。


## Configuration

The two sample configuration files lays at `config/configuration.yml.example` and `config/database.yml.example`, just copy, remove the trailing `.example` and modify them to your liking. 

If the `.yml` file dosen't exists, `.yml.example` will be used. So you can configure your app using only environment variables, especially when deploying to heroku or dokku.


## Development Build

```bash
$ bundle install --without production
$ rake db:migrate
$ rails s  # or `ln -s "$(pwd)" ~/.pow/order.ntust` if you're using Pow
```


## Contributing

1. Fork it.
2. Create your feature branch (`git checkout -b my-new-feature`).
3. Commit your changes (`git commit -m 'add some feature'`).
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request.
