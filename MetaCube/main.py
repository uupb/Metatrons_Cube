
import moderngl_window as mglw


class App(mglw.WindowConfig):
    window_size = 1920, 1080
    resource_dir = 'shaders'

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        # create screen aligned quad
        self.quad = mglw.geometry.quad_fs()
        # load shader program
        self.prog = self.load_program(vertex_shader='vert_PC.glsl',
                                      fragment_shader='19thfrag_PC.glsl')
        # Aspect ratio uniform
        self.set_uniform('resolution', self.window_size)

    def set_uniform(self, u_name, u_value):
        try:
            self.prog[u_name] = u_value
        except KeyError:
            print(f'uniform: {u_name} - not used in shader')

    def render(self, time, frame_time):
        self.ctx.clear()
        self.set_uniform('time', time)
        self.quad.render(self.prog)


if __name__ == '__main__':
    mglw.run_window_config(App)
