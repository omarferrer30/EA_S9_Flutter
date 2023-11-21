import { NextFunction, Request, Response } from 'express';
import mongoose from 'mongoose';
import News from '../models/News';

const newsList = [
    {
        title: 'Noticia 1',
        imageUrl: 'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQgByBT5IiAT_a2x9pUVb4VMoOrlzHH7Jrzj-HB5jzHlR4lNLMS',
        content: 'Primera noticia'
    },
    {
        title: 'Noticia 2',
        imageUrl: 'https://t2.ea.ltmcdn.com/es/posts/3/7/4/la_tortuga_como_mascota_24473_orig.jpg',
        content: 'Segunda noticia'
    },

];

const dameTodo = (req: Request, res: Response, next: NextFunction) => {
    return res.json(newsList);
}

export default { dameTodo };
