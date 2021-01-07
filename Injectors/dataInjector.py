import requests
import json
import lorem
import random


abailablePics = [
    'https://cdn.myanimelist.net/images/anime/1010/100084l.webp',
    'https://cdn.myanimelist.net/images/anime/1152/106337l.webp',
    'https://cdn.myanimelist.net/images/anime/1444/108005l.webp',
    'https://cdn.myanimelist.net/images/anime/1758/97736l.webp',
    'https://cdn.myanimelist.net/images/anime/1613/102576l.webp',
    'https://cdn.myanimelist.net/images/anime/1888/104008l.webp',
    'https://cdn.myanimelist.net/images/anime/1965/99667l.webp',
    'https://cdn.myanimelist.net/images/anime/1030/103383l.webp',
    'https://mfiles.alphacoders.com/877/877449.png',
    'https://mfiles.alphacoders.com/875/875062.png',
    'https://mfiles.alphacoders.com/872/872309.jpg',
    'https://mfiles.alphacoders.com/864/864718.jpg',
    'https://mfiles.alphacoders.com/833/833675.png',
    'https://mfiles.alphacoders.com/848/848624.jpg',
    'https://mfiles.alphacoders.com/831/831543.png'
]

for i in range(10):
    r = requests.post("http://192.168.1.7:4000/products/add/",
                        json={
                            "name": lorem.get_word(count=random.randint(1, 5)),
                            "pic":abailablePics[random.randint(0,len(abailablePics))],
                            'Tags':"Anime",
                            "Category":"Anime",
                            'price':random.randint(1,150000),
                            "OwnerID":13,
                            'Discription':lorem.get_paragraph(count = random.randint(1,10)),
                            "Quantity":random.randint(1,100),
                            })
    print(r.text)
