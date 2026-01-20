env = "dev"

instances = {
  default = {
	frontend  = {
	  ports = { ssh = 22 , nginx = 80 }
      instance_type = "t3.small"
	}
	mongodb   = {
	  ports = { ssh = 22 , mongodb = 27017 }
	  instance_type = "t3.small"
	}
	catalogue = {
	  ports = { ssh = 22 , app = 8080 }
	  instance_type = "t3.small"
	}
	redis     = {
	  ports = { ssh = 22 , redis = 6379 }
	  instance_type = "t3.small"
	}
	user      = {
	  ports = { ssh = 22 , app = 8080 }
	  instance_type = "t3.small"
	}
	cart      = {
	  ports = { ssh = 22 , app = 8080 }
	  instance_type = "t3.small"
	}
	shipping  = {
	  ports = { ssh = 22 , app = 8080 }
	  instance_type = "t3.small"
	}
	payment   = {
	  ports = { ssh = 22 , app = 8080 }
	  instance_type = "t3.small"
	}
	mysql     = {
	  ports = { ssh = 22 , mysql = 3306 }
	  instance_type = "t3.small"
	}
	rabbitmq  = {
	  ports = { ssh = 22 , rabbitmq = 5672 }
	  instance_type = "t3.small"
	}
  }
}
ami     = "ami-09c813fb71547fc4f"
zone_id = "Z06404431NXHJ1IDZF7W2"
