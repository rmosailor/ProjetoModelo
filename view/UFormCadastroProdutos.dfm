object FormCadastroProdutos: TFormCadastroProdutos
  Left = 0
  Top = 0
  Caption = 'Exemplo de cadastro de produtos'
  ClientHeight = 486
  ClientWidth = 660
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 660
    Height = 486
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 622
    ExplicitHeight = 433
    object pgcPrincipal: TPageControl
      Left = 1
      Top = 1
      Width = 658
      Height = 484
      ActivePage = tbsGeral
      Align = alClient
      TabOrder = 0
      ExplicitTop = 2
      ExplicitWidth = 622
      ExplicitHeight = 439
      object tbsGeral: TTabSheet
        Caption = 'Geral'
        object pnlPesquisaTopo: TPanel
          Left = 0
          Top = 0
          Width = 650
          Height = 41
          Align = alTop
          TabOrder = 0
          ExplicitWidth = 612
          object lblPesquisa: TLabel
            Left = 16
            Top = 16
            Width = 46
            Height = 15
            Caption = 'Pesquisa'
          end
          object edtPesquisa: TEdit
            Left = 80
            Top = 8
            Width = 409
            Height = 23
            TabOrder = 0
            OnKeyDown = dbgProdutosKeyDown
          end
          object btnPesquisar: TBitBtn
            Left = 504
            Top = 8
            Width = 75
            Height = 25
            Caption = 'Pesquisar'
            TabOrder = 1
            OnClick = btnPesquisarClick
          end
        end
        object dbgProdutos: TDBGrid
          Left = 0
          Top = 41
          Width = 650
          Height = 372
          Align = alClient
          DataSource = dsProdutos
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
          OnDblClick = dbgProdutosDblClick
          OnKeyDown = dbgProdutosKeyDown
        end
        object Panel1: TPanel
          Left = 0
          Top = 413
          Width = 650
          Height = 41
          Align = alBottom
          Caption = 
            'Pressione <INSERT> para novo registro / <DELETE> para exclus'#227'o /' +
            ' Dois Clicks (ou enter) para editar'
          TabOrder = 2
          ExplicitLeft = -4
          ExplicitTop = 352
          ExplicitWidth = 185
        end
      end
      object tbsManutencao: TTabSheet
        Caption = 'Manuten'#231#227'o'
        ImageIndex = 1
        TabVisible = False
        object lblId: TLabel
          Left = 16
          Top = 24
          Width = 11
          Height = 15
          Caption = 'ID'
        end
        object lblPartNumber: TLabel
          Left = 16
          Top = 53
          Width = 68
          Height = 15
          Caption = 'Part Number'
        end
        object lblDescricao: TLabel
          Left = 16
          Top = 82
          Width = 51
          Height = 15
          Caption = 'Descri'#231#227'o'
        end
        object edtId: TEdit
          Left = 96
          Top = 21
          Width = 241
          Height = 23
          TabOrder = 0
        end
        object edtPartNumber: TEdit
          Left = 96
          Top = 50
          Width = 241
          Height = 23
          TabOrder = 1
        end
        object edtDescricao: TEdit
          Left = 96
          Top = 79
          Width = 481
          Height = 23
          TabOrder = 2
        end
        object chkAtivo: TCheckBox
          Left = 520
          Top = 24
          Width = 57
          Height = 17
          Caption = 'Ativo'
          TabOrder = 3
        end
        object pnlBotoesManutencao: TPanel
          Left = 0
          Top = 413
          Width = 650
          Height = 41
          Align = alBottom
          TabOrder = 4
          ExplicitTop = 368
          ExplicitWidth = 614
          object btnOk: TBitBtn
            Left = 448
            Top = 8
            Width = 75
            Height = 25
            Kind = bkOK
            NumGlyphs = 2
            TabOrder = 0
            OnClick = btnOkClick
          end
          object btnCancela: TBitBtn
            Left = 529
            Top = 8
            Width = 75
            Height = 25
            Caption = 'Cancela'
            Kind = bkCancel
            NumGlyphs = 2
            TabOrder = 1
            OnClick = btnCancelaClick
          end
        end
      end
    end
  end
  object qryPesquisa: TFDQuery
    Left = 304
    Top = 224
  end
  object dsProdutos: TDataSource
    DataSet = qryPesquisa
    Left = 381
    Top = 219
  end
end
