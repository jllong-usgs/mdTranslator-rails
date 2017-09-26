run:
	docker-compose up -d

stop:
	docker-compose down

publish:
	docker build -t sciencebase/md-translator:latest .
	docker push sciencebase/md-translator:latest
