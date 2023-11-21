import express from 'express';
import controller from '../controllers/News';

const router = express.Router();

router.get('/', controller.dameTodo);

export = router;