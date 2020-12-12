DREAM XI 

App: 
- Create a dream football XI and where you can name a starting 11 and 3 bench players.  
- You can have multiple XI's and view them via your page. 

App structure:
    
Model:
        
        Users

            authentication
            email/password
            unique email
            has_many Teams

        Teams

            belongs_to User
            has_many Players

        Players
        
            belongs_to Team 


    