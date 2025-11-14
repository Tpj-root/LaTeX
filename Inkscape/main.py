import inkex

class Hello(inkex.EffectExtension):
    def effect(self):
        text = inkex.TextElement()
        text.text = "Hello!"
        text.set('x', '50')
        text.set('y', '50')
        self.svg.getroot().add(text)

if __name__ == '__main__':
    Hello().run()

