run:
	docker-compose up -d

stop:
	docker-compose down

publish:
	docker build -t sciencebase/md-translator .
	docker push sciencebase/md-translator