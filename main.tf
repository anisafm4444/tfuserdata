provider "aws" {
  region = "us-east-1"
}

data "template_file" "scripts" {
  template = "${file("scripts.tpl")}"
  vars = {
    instance_address = "${aws_instance.web.private_ip}"
  }
}
resource "aws_instance" "web" {
  ami           = "ami-04763b3055de4860b"
  instance_type = "t2.micro"
  key_name = "FriscoEC2KeyPair"
  user_data = "${file("scripts.sh")}"
  #user_data = "${data.template_file.scripts.rendered}"
  security_groups = ["WebDMZ"]
  }


resource "aws_instance" "web2" {
  ami           = "ami-04763b3055de4860b"
  instance_type = "t2.micro"
  key_name = "FriscoEC2KeyPair"
  #user_data = "${file("scripts.tpl")}"
  user_data = "${data.template_file.scripts.rendered}"
  security_groups = ["WebDMZ"]
  }