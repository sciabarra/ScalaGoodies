enablePlugins(DockerPlugin)

imageNames in docker := Seq(ImageName("localhost:5000/akkahttp:latest"))

dockerAutoPackageJavaApplication()
