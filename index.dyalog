:Class Index : Blank
⍝Blank MiServer page that will be called from GitHub

    :Include #.HTMLInput
    :Include #.JSON

	⍝ Edit the following lines to suit your setup.
    ServiceUser←'miserver'		  ⍝ The user the webServer is running as
    GitHubBranch←'Staging'		  ⍝ The Git Hub Branch we want to use
    GitHubRepository←'/MiServer/MiSite/'  ⍝ Directory of your website clone
    PayloadDirectory←'/MiServer/MiDeploy' ⍝ The Directory of this payload server
	⍝ Stop Editing here



    NEWLINE←⎕UCS 13 10

      GetResult←{⍵[1+⍵⍳⊂⍺]}		⍝ a DFN to get the value of an item
      FindStr  ←{⍵⍳⊂⍺}			⍝ A DFN to find a string

    ∇ Render req;html;json;form
      :Access Public
      html←'Dyalog Deployment Server!',NEWLINE
      html,←'This page should only be called from Github, if you''re seeing this, bog-off!',NEWLINE
      html,←'Running on MiServer2.',NEWLINE

      json←⊃'payload'GetResult(,req.Data)                ⍝ JSON Data from Github

     :If 0<⍴json                        ⍝ Data isn't nothing...
       #.aa←json                        ⍝ Let me sod about with it in the session
					⍝ Convert our json to an APL Array (The long way for now while JSONtoOBJ isn't working)
       GitHubData←⎕XML #.JSON.JSONtoXML json 

       :If ({⍵⍳⊂'ref'}(,GitHubData))<(⍴(,GitHubData))
         :If (⊂'refs/heads/',GitHubBranch) ≡ 'ref'GetResult(,GitHubData)
					⍝ Something was pushed to this server, we want to restart our server here
                html,←'Running Code for ',GitHubBranch,NEWLINE
					⍝ We use shell scripts to do the grunt-work,
					⍝ This means we can easily run commands as other users.

					⍝ Update the local Git Repository as the ServiceUser
		⎕SH 'sudo -u ',ServiceUser,' ',PayloadDirectory,'/DeployScripts/gitPull.sh ',GitHubRepository
					⍝ Email the user
		⎕SH PayloadDirectory,'/DeployScripts/mailUser.sh ','email'GetResult(,GitHubData),' ',GitHubBranch
					⍝ Bounce the box, until we can check the service is running without GitHub Timing out.
		⍝⎕SH 'sudo ',PayloadDirectory,'/DeployScripts/restartServer.sh' ⍝just reboot the server
		
         :EndIf
        :Else
                html,←'Nothing to do here...',NEWLINE
        :EndIf
      :EndIf

      html,←'<br/>TESTING</br>'
      html,←'<form action="index.dyalog" method="post">'
      html,←'<textarea name="payload" rows="30" cols="150"></textarea><br />'
      html,←'<input type="submit">'
      html,←'</form>'
      req.Return html
    ∇



:EndClass

