## Setup Elastalert + ELK on Docker

This repository includes the setup steps to set up the Elastalert alerting platform on a Docker-based environment. This deployment makes use of:

- Docker
- Docker Compose
- curl
- git
- [Composer](https://getcomposer.org)

**NOTE:** While there is an official [Yelp repository](https://github.com/bitsensor/yelp-elastalert) for Elastalert, this system uses the [Bitsensor version](https://github.com/bitsensor/yelp-elastalert) as it includes a bit of extra functionality.

### Setup

To set up the environment, run the `setup.sh` script (this assumes you're using `bash`):

```
./setup.sh
```

### Resources

- [Elastalert documentation](https://elastalert.readthedocs.io/en/latest/)
- [Bitsensor Elastalert repository](https://github.com/bitsensor/yelp-elastalert)