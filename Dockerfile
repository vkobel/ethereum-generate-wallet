FROM python

RUN apt-get install -y openssl
COPY ./requirements.txt ./requirements.txt
COPY ./ethereum-wallet-generator.py ./ethereum-wallet-generator.py
RUN pip install -r ./requirements.txt

CMD [ "python", "./ethereum-wallet-generator.py" ]