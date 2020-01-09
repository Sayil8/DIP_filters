unit Unit4;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids,
  StdCtrls, ComCtrls, Buttons;

type

  { TForm4 }

  TForm4 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    StaticText1: TStaticText;
    StringGrid1: TStringGrid;
    TrackBar1: TTrackBar;
    procedure FormCreate(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    valor : integer;
  end;

var
  Form4: TForm4;

implementation

{$R *.lfm}

{ TForm4 }

procedure TForm4.TrackBar1Change(Sender: TObject);
var
  i,j : integer;
begin
  valor:=trackbar1.position;
  //llenamos la matriz con ceros

   //recalculamos dimensiones
    stringgrid1.ColCount:=valor;
    stringgrid1.RowCount:=valor;
       for i:=0 to valor-1 do begin
     for j:=0 to valor-1 do begin
         stringgrid1.Cells[i,j] :='0';
     end;
   end;


end;

procedure TForm4.FormCreate(Sender: TObject);


begin

end;

end.

