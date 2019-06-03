# Full Stack Challenge 2019
[![](https://frcdn.beenverified.com/assets/img/0930cc4efcc5fb56b36af463f5de1b1f.svg)](https://www.beenverified.com/)

A solution by Joan Quesada.

You can check the requirements at [Full Stack Challenge 2019](https://drive.google.com/file/d/1pDolgbZ-tH192V9HTLl30f85X44DAs1Y/view?usp=sharing).

Special thanks for creators and mainteiners of [Sidekiq](https://github.com/mperham/sidekiq) and [MetaInspector](https://www.rubydoc.info/gems/metainspector/4.2.1) gems.

# Things you may want to know

## Ruby and Rails versions
- Ruby v2.6.3
- Rails v5.2.3

## How works the algorithm to creates shorts URLs?
- This short_url generator is too simple, uses Base64 module and the initials chars of the original_url string to generate a code.
- Starts using the first 3 chars of original_url string to generate a Base64 code, and take another and another char to generate a new code if that code already exist on the database.
```sh
  def generate_short_url(domain_name)
    var = 2
    loop do
      self.short_url = domain_name + (Base64.encode64(self.original_url)[0..var])
      if Url.find_by_short_url(self.short_url).nil?
        break
      else
        var = var + 1
      end
    end
  end
```

# What is included in the "box"?
You can enjoy an API that includes 3 endpoints:
### create
Supports POST method, receive the original_url and creates a short_url.
You can test using your browser and navigates to index page and click **Shorten!**:
```sh
http://localhost:300
```
or can you test using cURL, for example
```sh
$ curl -X POST -d "original_url=https://www.google.com" http://localhost:3000/urls/create/
```
### show 
Supports GET method, receive shortened_url and redirects to the original_url.
You can test using your browser and navigates to a shortened_urls created previously, for example:
```sh
http://localhost:3000/d3d3
```
or can you test using cURL, for example
```sh
$ curl http://localhost:3000/d3d3
```
### top
Supports GET method, this endpoint without parameters returns to you the top 100 most frequently accessed shortened URLs.
You can test using your browser and navigates to a shortened_urls created previously, for example:
You can test using your browser and navigates to:
```sh
http://localhost:3000/top
```
or can you test using cURL, for example
```sh
$ curl http://localhost:3000/top
```

# Where do you want try the application?
## Using Docker
**1. First, test your Docker Compose installation:**
```sh
$ docker-compose --version
docker-compose version 1.24.0, build 0aa59064.
```
If you don't receive a message like this please [install Docker Compose](https://docs.docker.com/compose/install/) or check your instalation.

**2. Download the application preparared for Docker Compose [here!](https://www.dropbox.com/s/s2supir8s1xojph/url_shortener_docker_challenge2019.zip?dl=1) and unzip it.**

**3. This URLs_Shortener application is very easy to install and deploy in a Docker container. Execute the following commands to build and up the application:**
```sh
$ cd url_shortener_docker_challenge2019
$ sudo docker-compose build
$ sudo docker-compose up
```
This will create the URLs_Shortener image and pull in the necessary dependencies.
After the last command you can get something like this:
```sh
listening on IPv4 address "0.0.0.0", port 5432
listening on IPv6 address "::", port 5432
istening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
database system was shut down at 2019-06-02 09:08:54 UTC
database system is ready to accept connections
```
[![](https://www.dropbox.com/s/vp7ol352rfgdlvq/up.jpg?dl=1)]()
**4. Don't forget the final step... create and migrate the database. In another terminal, run:**
```sh
$ cd url_shortener_docker_challenge2019
$ sudo docker-compose run web rake db:create
$ sudo docker-compose run web rake db:migrate
```
**5. That’s done :-)**

Your app should now be running on port 3000 on your Docker daemon.
Go to [http://localhost:3000](http://localhost:3000) on a web browser to enjoy the URLs_Shortener!
[![](https://www.dropbox.com/s/5h0zezdj33blm5e/index%20shortener.png?dl=1)]()
And please check this aditional endpoint [http://localhost:3000/top](http://localhost:3000/top) to see the **TOP 100 of URLs_Shortener**
[![](https://www.dropbox.com/s/dqz7pw7xexo68a6/top%20shortener.png?dl=1)]()

***Just in case...***
By default, this application will expose port 3000, so change this within the Dockerfile if necessary. When ready, simply use the Dockerfile to build the image and up the application, **repeat the previous commands again**.

## Using Heroku
Let me a minute...

# Next steps
 - Make a awesome web client for my URLs_shortener   "-_-"
