FROM public.ecr.aws/lambda/python:3.7

COPY requirements.txt .
RUN pip3 install -r requirements.txt -t .

COPY train.py .
RUN python train.py

COPY app.py .

CMD ["app.handler"]