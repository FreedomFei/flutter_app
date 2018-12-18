API informations

API

You can get all manga informations, chapters and mymanga with mangaeden's API. 
All the informations are sent in JSON format. 
You can either use HTTP or HTTPS (advised if you need to use the mymanga's API). 
Important: we require every API user to have a link to our site in their application/site. 
New: We also support CORS now 


Manga List

URL: https://www.mangaeden.com/api/list/[language]/ 
Where [language] can be 0 (English) or 1 (Italian) 
Returned data: 
- dictionaries in the key "manga" contains the manga's image ("im"), title ("t"), ID ("i"), alias ("a"), status ("s"), category ("c"), last chapter date ("ld"), hits ("h") 
- "page", "start", "end" and "total" are self explanatory 
Manga List splitted in pages
URL: https://www.mangaeden.com/api/list/[language]/?p=X 
Same as above but returns only 500 manga's informations (from manga X*500 to (X+1)*500, where X is the page fetched from the GET parameter 'p') 
Manga List splitted in pages with variable page size
URL: https://www.mangaeden.com/api/list/[language]/?p=X&l=Y 
Same as above but returns only Y manga's informations (from manga X*Y to (X+1)*Y) [25 < Y < 1500] 


Manga info and chapters list

URL: https://www.mangaeden.com/api/manga/[manga.id]/ 
Example: https://www.mangaeden.com/api/manga/4e70e9f6c092255ef7004336/ 
Where [manga.id] is the manga's id you can get with the previous api call 
Returned data: all the informations and chapters of the manga. 
Chapter's array explained
Example of a chapter array element: 
[ 
5, # <-- chapter's number 
1275542373.0, # <-- chapter's date 
"5", # <-- chapter's title 
"4e711cb0c09225616d037cc2" # <-- chapter's ID (chapter.id in the next section) 
], 


Chapter pages

URL: https://www.mangaeden.com/api/chapter/[chapter.id]/ 
Example: https://www.mangaeden.com/api/chapter/4e711cb0c09225616d037cc2/ 
Where [chapter.id] is the chapter's id you can get with the previous api call. 
Returned data: the images's urls and sizes of the chapter 


Login

URL: https://www.mangaeden.com/ajax/login/?username=X&password=Y 
Where X and Y are your username and password. 
The backend will save your session in the cookie so make sure to keep them in your code. 

Logout

URL: https://www.mangaeden.com/ajax/logout/ 

MyManga

URL: https://www.mangaeden.com/api/mymanga/ 
Returns all manga saved in the user's mymanga list with all the informations about the manga, latest available chapter and last chapter read by the user. 


Note: to download an image you have to add "https://cdn.mangaeden.com/mangasimg/" ahead the image's url. 
Note: the dates are unix time stamps.


GridView.builder(
    itemCount: 20,
    gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
    itemBuilder: (BuildContext context, int index) {
      return new GestureDetector(
        child: new Card(
          elevation: 5.0,
          child: new Container(
            alignment: Alignment.center,
            child: new Text('Item $index'),
          ),
        ),
        onTap: () {

        },
      );
    });
