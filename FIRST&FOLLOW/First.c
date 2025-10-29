 #include<stdio.h>
  #include<string.h>

 #include<stdlib.h>
  #include<ctype.h>
  
 #define MAX 20
  char production[MAX][20];
  int n;
  
int isnonterminal(char c)
{
    return (c>='A' && c<='Z');
}

void addtoset(char set[],char c)
{
    for(int i=0;set[i]!='\0';i++)
    {
        if(set[i]==c)
        {
            return;
        }
    }
    int len=strlen(set);
    set[len]=c;
    set[len+1]='\0';
}


void first(char result[],char c)
{
    for(int i=0;i<n;i++)
    {
        if(production[i][0]==c)
        {
            int j=2;
            while(production[i][j]!='\0')
            {
                char sym=production[i][j];
                if(sym=='#')
                {
                    addtoset(result,'#');
                    break;
                }
                else if(!isnonterminal(sym))
                {
                    addtoset(result,sym);
                    break;
                }
                else
                {
                    char subresult[20]="";
                    first(subresult,sym);
                    int epsilon=0;
                    for(int k=0;subresult[k]!='\0';k++)
                    {
                        if(subresult[k]=='#')
                        {
                            epsilon=1;
                        }
                        else
                        {
                            addtoset(result,subresult[k]);
                        }
                    }
                    if(epsilon)
                    {
                        break;
                    }
                }
                j++;
            }
            
        }
    }
}

int main()
{
    printf("enter the number of productions : ");
    scanf("%d",&n);
    
    printf("enter  productions : ");
    for(int i=0;i<n;i++)
    {
        scanf("%s", production[i]);
    }
    
    char nonterm[MAX][20];
    int n_count=0;
    int seen[256]={0};
    for(int i=0;i<n;i++)
    {
        char lhs=production[i][0];
        if(!seen[(unsigned char)lhs])
        {
            seen[(unsigned char)lhs]=1;
            nonterm[n_count][0]=lhs;
            nonterm[n_count][1]='\0';
            n_count++;
            
        }
        
    }
    
    for(int i=0;i<n_count;i++)
    {
        char c=nonterm[i][0];
        char result[20]="";
        first(result,c);
        
        printf("first (%c) = { ",c);
        for(int j=0;result[j]!='\0';j++)
        {
            printf("%c ",result[j]);
            if(result[j+1]!='\0')
            {
                printf(", ");
            }
        }
        printf("}\n");
    }
    
}


 
