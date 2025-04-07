build:
	docker build -t onbbu/sandobx .

start:
	docker run -p 8080:8080 onbbu/sandobx