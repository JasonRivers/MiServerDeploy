:Class Index : Blank
⍝Blank MiServer page that will be called from GitHub

    :Include #.HTMLInput
    :Include #.JSON

    NEWLINE←⎕UCS 13 10

    ∇ Render req;html;json;form
      :Access Public
      html←'Dyalog Deployment Server!',NEWLINE
      html,←'This page should only be called from Github, if you''re seeing this, bog-off!',NEWLINE
      html,←'Running on MiServer2.',NEWLINE

      json←⊃req.Data[;2]                ⍝ This is the returned Data from Github

     :If 0<⍴json                        ⍝ Data isn't nothing...
       #.aa←json                        ⍝ Let me sod about with it in the session
       GitHubData←⎕XML #.JSON.JSONtoXML json ⍝ Convert our json to an APL Array (The long way for now while JSONtoOBJ isn't working)
	BranchLocation←{⍵[1+⍵⍳⊂'ref']}

       :If ({⍵⍳⊂'ref'}(,GitHubData))<(⍴(,GitHubData))
         :If (⊂'refs/heads/Staging') ≡BranchLocation(,GitHubData)
                        ⍝ Something was pushed to "Staging", we want to restart our staging server here
                html,←'Running Code for Staging',NEWLINE
         :ElseIf (⊂'refs/heads/Live') ≡BranchLocation(,GitHubData)
                        ⍝ Something was pushed to "Live", We want to restart our live server here
                html,←'Running Code for Live',NEWLINE
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

