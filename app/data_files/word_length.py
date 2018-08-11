from os import listdir

for file in listdir("."):
    try:
        with open(file, encoding="utf-8") as f:
            words = f.read().split()[1:]
            avg = sum([len(w) for w in words]) / len(words)
            print(avg)
    except:
        pass
        
        
