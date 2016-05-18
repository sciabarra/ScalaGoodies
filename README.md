![ScalaGoodies](http://michele.sciabarra.com/2016/06/17/scala/ScalaGoodies/ScalaGoodies.png)

documentation is here:
http://michele.sciabarra.com/2016/06/17/scala/ScalaGoodies/

In short:

```
git remote add ScalaGoodies https://github.com/sciabarra/ScalaGoodies
git fetch --all
```

If you want an advanced sbt:

```
git merge ScalaGoodies/esbt
```

If you want Scala completions and reformatting with Atom:

```
git merge ScalaGoodies/completion
```

If you want a notebook, both external (Jupyter) and internal in Atom (Hydrogen):

```
git merge worksheet
```

Then complete with 

```
bin/install.sh
```

That's all.

